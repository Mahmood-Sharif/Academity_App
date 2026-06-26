<?php

namespace App\Database\Seeds;

use App\Entities\User;
use App\Models\ClassModel;
use CodeIgniter\Database\Seeder;
use DateInterval;
use DateTimeImmutable;
use DateTimeZone;

class DemoSeeder extends Seeder
{
    private const PASSWORD = 'Password123!';

    public function run(): void
    {
        $admin = $this->demoUser(
            'admin@academity.test',
            'Academity Demo Admin',
            ['superadmin', 'admin', 'developer', 'user', 'coach'],
            '97330000001',
            '1990-01-01'
        );
        $owner = $this->demoUser(
            'owner@academity.test',
            'Mariam Demo Owner',
            ['admin', 'user'],
            '97330000002',
            '1988-03-10'
        );
        $coach = $this->demoUser(
            'coach@academity.test',
            'Omar Demo Coach',
            ['coach', 'user'],
            '97330000003',
            '1992-08-15'
        );
        $student = $this->demoUser(
            'student@academity.test',
            'Layla Demo Student',
            ['user'],
            '97330000004',
            '2013-05-20',
            'Female'
        );

        $basketballMedia = $this->media('image/jpeg', 'images/Basketball.jpg');
        $footballMedia   = $this->media('image/jpeg', 'images/Football.jpg');
        $swimmingMedia   = $this->media('image/jpeg', 'images/Swimming.jpg');
        $padelMedia      = $this->media('image/jpeg', 'images/Padel.jpg');
        $academyMedia    = $this->media('image/jpeg', 'images/AcademityDemoAcademy.jpg');

        $basketballId = $this->sport('Basketball', $basketballMedia);
        $footballId   = $this->sport('Football', $footballMedia);
        $swimmingId   = $this->sport('Swimming', $swimmingMedia);
        $this->sport('Padel', $padelMedia);

        $academyId = $this->academy([
            'name'        => 'Academity Demo Academy',
            'location'    => 'Manama, Bahrain',
            'phone'       => '97317000000',
            'description' => 'Demo academy for local development and portfolio walkthroughs.',
            'media_id'    => $academyMedia,
            'owner_id'    => $owner->id,
            'sport_id'    => $basketballId,
        ]);

        $this->linkCoach($academyId, $coach->id);
        $this->gallery($academyId, $academyMedia, 0);
        $this->gallery($academyId, $basketballMedia, 1);
        $this->gallery($academyId, $footballMedia, 2);
        $this->gallery($academyId, $swimmingMedia, 3);

        $classId = $this->class([
            'class_name'   => 'Demo Youth Basketball',
            'min_age'      => 10,
            'max_age'      => 16,
            'academy_id'   => $academyId,
            'max_capacity' => 18,
            'min_duration' => 8,
            'max_duration' => 12,
            'coach_id'     => $coach->id,
            'reg_code'     => ClassModel::generateRegCode(),
        ]);

        $this->classTiming($classId, 'SUN', '17:00:00', '18:30:00');
        $this->classTiming($classId, 'TUE', '17:00:00', '18:30:00');

        $offerId = $this->offer('Demo sibling discount');
        $this->offerClass($classId, $offerId);

        $now = new DateTimeImmutable('now', new DateTimeZone('Asia/Bahrain'));
        $this->price($classId, '45.00', $now->format('Y-m-d H:i:s'), null, null);

        $start = $now->format('Y-m-d');
        $end   = $now->add(new DateInterval('P12W'))->format('Y-m-d');
        $this->enrollment($student->id, $classId, $start, $end, '45.00');
    }

    /**
     * @param string[] $groups
     */
    private function demoUser(
        string $email,
        string $name,
        array $groups,
        string $phone,
        string $dob,
        string $gender = 'Male'
    ): User {
        $users = auth()->getProvider();
        $user  = $users->findByCredentials(['email' => $email]);

        if ($user === null) {
            $user = new User([
                'username' => null,
                'email'    => $email,
                'password' => self::PASSWORD,
                'name'     => $name,
                'phone'    => $phone,
                'dob'      => $dob,
                'gender'   => $gender,
            ]);

            $users->save($user);
            $user = $users->findById($users->getInsertID());
        }

        if (method_exists($user, 'activate')) {
            $user->activate();
        }

        foreach ($groups as $group) {
            if (! $user->inGroup($group)) {
                $user->addGroup($group);
            }
        }

        return $user;
    }

    private function media(string $mimeType, string $url): int
    {
        return $this->upsert('media', 'media_id', ['url' => $url], [
            'mime_type' => $mimeType,
            'url'       => $url,
        ]);
    }

    private function sport(string $name, int $mediaId): int
    {
        return $this->upsert('sports', 'sport_id', ['name' => $name], [
            'name'     => $name,
            'media_id' => $mediaId,
        ]);
    }

    /**
     * @param array<string,mixed> $data
     */
    private function academy(array $data): int
    {
        return $this->upsert('academies', 'academy_id', ['name' => $data['name']], $data);
    }

    /**
     * @param array<string,mixed> $data
     */
    private function class(array $data): int
    {
        return $this->upsert('classes', 'class_id', [
            'class_name' => $data['class_name'],
            'academy_id' => $data['academy_id'],
        ], $data);
    }

    private function classTiming(int $classId, string $day, string $start, string $end): void
    {
        $this->upsert('class_timings', 'timing_id', [
            'class_id'    => $classId,
            'day_of_week' => $day,
            'start_time'  => $start,
        ], [
            'class_id'    => $classId,
            'day_of_week' => $day,
            'start_time'  => $start,
            'end_time'    => $end,
        ]);
    }

    private function offer(string $description): int
    {
        return $this->upsert('offers', 'offer_id', ['description' => $description], [
            'description' => $description,
        ]);
    }

    private function offerClass(int $classId, int $offerId): void
    {
        $this->db->table('offer_classes')->ignore()->insert([
            'class_id' => $classId,
            'offer_id' => $offerId,
        ]);
    }

    private function price(int $classId, string $price, string $startTime, ?string $endTime, ?int $offerId): int
    {
        return $this->upsert('prices', 'price_id', [
            'class_id' => $classId,
            'end_time' => $endTime,
        ], [
            'class_id'    => $classId,
            'price'       => $price,
            'start_time'  => $startTime,
            'end_time'    => $endTime,
            'offer_id'    => $offerId,
        ]);
    }

    private function enrollment(int $studentId, int $classId, string $startDate, string $endDate, string $priceValue): int
    {
        return $this->upsert('enrollments', 'enrollment_id', [
            'student_id' => $studentId,
            'class_id'   => $classId,
        ], [
            'student_id'   => $studentId,
            'class_id'     => $classId,
            'start_date'   => $startDate,
            'end_date'     => $endDate,
            'price_value'  => $priceValue,
        ]);
    }

    private function gallery(int $academyId, int $mediaId, int $index): void
    {
        $this->db->table('gallery')->ignore()->insert([
            'academy_id' => $academyId,
            'media_id'   => $mediaId,
            'index'      => $index,
        ]);
    }

    private function linkCoach(int $academyId, int $coachId): void
    {
        $this->db->table('academy_coaches')->ignore()->insert([
            'academy_id' => $academyId,
            'coach_id'   => $coachId,
        ]);
    }

    /**
     * @param array<string,mixed> $match
     * @param array<string,mixed> $data
     */
    private function upsert(string $table, string $primaryKey, array $match, array $data): int
    {
        $builder = $this->db->table($table);
        $row     = $builder->where($match)->get()->getRowArray();

        if ($row !== null) {
            $this->db->table($table)->where($primaryKey, $row[$primaryKey])->update($data);
            return (int) $row[$primaryKey];
        }

        $this->db->table($table)->insert($data);

        return (int) $this->db->insertID();
    }
}
