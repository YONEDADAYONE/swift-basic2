<?php
    namespace Model\Notification;

    // vendorをInclude済みであること

    class Constant
    {
        const PUSH_PEM_FILE = 'certificates/push_development.pem';
        const AUTHORITY_PEM_FILE = 'certificates/entrust_root_certification_authority.pem';
    }

    class Push
    {
        function executeRemotePush ($text)
        {
            $push = new \ApnsPHP_Push(\ApnsPHP_Abstract::ENVIRONMENT_SANDBOX, dirname(__FILE__) . Constant::PUSH_PEM_FILE);
            $push->setRootCertificationAuthority(dirname(__FILE__) . Constant::AUTHORITY_PEM_FILE);
            $push->connect();

            $message = new \ApnsPHP_Message('b0bc62f089456810602a3bf07eabb1ca8d8190d566f3fccccb4b070e5491f7a4');
            $message->setContentAvailable(true);
            $message->setBadge(0);
            $message->setSound();
            $message->setText($text);
            $message->setExpiry(30);

            $push->add($message);
            $push->send();
            $push->disconnect();

            $aErrorQueue = $push->getErrors();
            if (!empty($aErrorQueue)) {
                var_dump($aErrorQueue);

                return false;
            }
            return true;
        }
    }
