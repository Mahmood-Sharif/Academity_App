<?php

namespace App\Controllers\Api;

use App\Models\MediaModel;
use App\Models\StudentModel;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\RESTful\ResourceController;
use Exception;

class Students extends ResourceController
{
    public function index(): ResponseInterface
    {
        $model = new StudentModel();
        $data = array();
        $data['hello'] = $model->orderBy('student_id', 'DESC')->findAll();
        return $this->respond($data);
    }

    public function show($id = null): ResponseInterface
    {
        $model = new StudentModel();
        $data = $model->find($id);
        if ($data) {
            return $this->respond($data);
        } else {
            return $this->failNotFound('Student Not Found');
        }
    }

    public function uploadProfilePicture(): ResponseInterface
    {
        $userId = auth()->id();
        $users = auth()->getProvider();
        $file = $this->request->getFile('file');

        try {
            if (!array_search($file->getMimeType(), ['image/png', 'image/jpeg'])) {
                throw new Exception("Invalid file type", 400);
            }
            ['url' => $url, 'media_id' => $mediaId] = (new MediaModel())->uploadMedia($file);
            $user = $users->findById($userId);
            $user->profile_image = $mediaId;
            $users->save($user);

            return $this->respond([
                'image_url' => base_url($url),
            ]);

        } catch (Exception $ex) {
            if ($ex->getCode() === 400) {
                return $this->fail('Invalid file type', 400);
            }
            return $this->fail('Unknown Error', 500);
        }
    }
}
