<?php

namespace App\Models;

use CodeIgniter\Files\File;
use CodeIgniter\HTTP\Files\UploadedFile;
use CodeIgniter\Model;

class MediaModel extends Model
{
    protected $table = 'media';
    protected $primaryKey = 'media_id';

    protected $allowedFields = [
      'mime_type',
      'url',
    ];

    protected $returnType = \App\Entities\Media::class;

    /**
     * Upload a file and store it in the database.
     * @return array<string,mixed>
     */
    public function uploadMedia(UploadedFile|null $uploadedFile, int|null $maxBytes = null): array
    {
        if ($uploadedFile->hasMoved()) {
            return ['errors' => 'file has moved'];
        }
        if ($maxBytes != null && $uploadedFile->getSize() > $maxBytes) {
            return ['errors' => 'file too large'];
        }
        $filepath = 'uploads/' . $uploadedFile->store();
        $file = new File(WRITEPATH . $filepath);
        $mediaId = $this->insert([
            'mime_type' => $file->getMimeType(),
            'url'       => $filepath,
        ], true);

        return [
            'url'      => $filepath,
            'media_id' => $mediaId,
            'type'     => $file->getMimeType(),
        ];
    }

    /**
     * Delete a file
     */
    public function deleteMedia(int $mediaId, bool $unlink = true): bool
    {
        $media = $this->find($mediaId);

        if ($unlink) {
            unlink(ROOTPATH . 'writable/' . $media->url);
        }

        return $this->delete($mediaId);
    }

}
