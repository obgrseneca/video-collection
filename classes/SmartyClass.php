<?php
require 'smarty/Smarty.class.php';

class vcSmarty extends Smarty {

    public function __construct() {
        $this->setTemplateDir($_SESSION['basedir'].'/smarty/templates/');
        $this->setCompileDir($_SESSION['basedir'].'/smarty/templates_c/');
        $this->setConfigDir($_SESSION['basedir'].'/smarty/configs/');
        $this->setCacheDir($this->cache_dir = $_SESSION['basedir'].'/smarty/cache/');
    }
}
?>