<?php
    class DbConnectionClass {
        private $dbConnection;
        private $dbSelection;
        private $dbHost;
        private $dbUser;
        private $dbPassword;
        private $dbName;

        public function __construct() {
            include($_SESSION['baseDir'].'/config.inc');

            $this->dbConnection = mysql_connect($this->dbHost, $this->dbUser, $this->dbPassword);
            if (!empty($this->dbName)) {
                $this->dbSelection = mysql_select_db($this->dbName, $this->dbConnection);
            } else {
                $this->dbSelection = false;
            }
        }

        public function getDbSelection() {
            return $this->dbSelection;
        }

        public function getDbConnection() {
            return $this->dbConnection;
        }

        public function __destruct() {
            mysql_close($this->dbConnection);
        }

        public function readData($sqlString) {
            $result = mysql_query($sqlString, $this->dbConnection);

            $dataSet = array();
            while ($row = mysql_fetch_assoc($result)) {
                array_push($dataSet, $row);
            }

            return $dataSet;
        }

        public function writeData($sql, $returnId=false) {
            $result = mysql_query($sql);
            if ($returnId && $result) {
                $result = mysql_insert_id();
            }

            return $result;
        }

        public function addData($data) {
            $tableName = $data[0];
            $newData = $data[1];
            $sql = '';
            foreach ($newData as $newLine) {
                $sql1 = '';
                $sql2 = '';
                foreach ($newLine as $k => $v) {
                    $sql1 .= $k.',';
                    $sql2 .= $v.',';
                }
                $sql .= 'INSERT INTO '.$tableName.' ('.rtrim($sql1,',').') VALUES ('.rtrim($sql2,',').'); ';
            }
            return $this->writeData($sql);
            //echo $sql."<br /><br />";
        }


        public function editData($data) {
            $tableName = $data[0];
            $changedData = $data[1];
            $sql = '';
            foreach ($changedData as $changedLine) {
                $sql .= 'UPDATE '.$tableName. ' SET ';
                $sqlInternal = '';
                foreach ($changedLine[0] as $k => $v) {
                    $sqlInternal .= $k. ' = ' .$v. ',';
                }
                $sql .= rtrim($sqlInternal,','). ' WHERE ' .key($changedLine[1]). ' = ' .$changedLine[1][key($changedLine[1])]. '; ';
            }
            return $this->writeData($sql);
            //echo $sql."<br /><br />";
        }

        public function escapeString($string, $type='int') {
            $escapedString = mysql_real_escape_string($string);
            if ($type == 'str')
                $escapedString = '\'' . $escapedString . '\'';
            return $escapedString;
        }
    }
?>