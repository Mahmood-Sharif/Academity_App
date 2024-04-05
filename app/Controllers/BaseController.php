<?php

namespace App\Controllers;

use App\Models\MediaModel;
use CodeIgniter\Controller;
use CodeIgniter\Files\File;
use CodeIgniter\HTTP\CLIRequest;
use CodeIgniter\HTTP\Files\UploadedFile;
use CodeIgniter\HTTP\IncomingRequest;
use CodeIgniter\HTTP\RequestInterface;
use CodeIgniter\HTTP\ResponseInterface;
use Psr\Log\LoggerInterface;

/**
 * Class BaseController
 *
 * BaseController provides a convenient place for loading components
 * and performing functions that are needed by all your controllers.
 * Extend this class in any new controllers:
 *     class Home extends BaseController
 *
 * For security be sure to declare any new methods as protected or private.
 */
abstract class BaseController extends Controller
{
    /**
     * Instance of the main Request object.
     *
     * @var CLIRequest|IncomingRequest
     */
    protected $request;

    /**
     * An array of helpers to be loaded automatically upon
     * class instantiation. These helpers will be available
     * to all other controllers that extend BaseController.
     *
     * @var array
     */
    protected $helpers = [];

    /**
     * Be sure to declare properties for any property fetch you initialized.
     * The creation of dynamic property is deprecated in PHP 8.2.
     */
    // protected $session;

    /**
     * @return void
     */
    public function initController(RequestInterface $request, ResponseInterface $response, LoggerInterface $logger): void
    {
        // Do Not Edit This Line
        parent::initController($request, $response, $logger);

        // Preload any models, libraries, etc, here.

        // E.g.: $this->session = \Config\Services::session();
    }

    /**
     * Upload a file and store it in the database.
     * @return array<string,mixed>
     */
    public static function uploadMedia(UploadedFile|null $uploadedFile, int|null $maxBytes = null): array
    {
        if ($uploadedFile->hasMoved()) {
            return ['errors' => 'file has moved'];
        }
        if ($maxBytes != null && $uploadedFile->getSize() > $maxBytes) {
            return ['errors' => 'file too large'];
        }
        $filepath = 'uploads/' . $uploadedFile->store();
        $file = new File(WRITEPATH . $filepath);
        $mediaModel = new MediaModel();
        $mediaId = $mediaModel->insert([
            'mime_type' => $file->getMimeType(),
            'url'       => $filepath,
        ], true);

        return [
            'url'      => $filepath,
            'media_id' => $mediaId,
            'type'     => $file->getMimeType(),
        ];
    }
}
