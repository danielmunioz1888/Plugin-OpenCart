<?php
class ModelTodopagoTransaccion extends Model {
    
    const NEW_ORDER = 0;
    const FIRST_STEP = 1;
    const SECOND_STEP = 2;
    const TRANSACTION_FINISHED = 3;
    
    public function getTransaction($orderId) {
        $query = $this->db->query("SELECT * FROM ".DB_PREFIX."todopago_transaccion WHERE id_orden = ".$orderId);
        
        return $query->row;
    }
    
    public function getStep($orderId){
        $transaction = $this->getTransaction($orderId);
        if ($transaction == null){
            $step = self::NEW_ORDER;
        }
        else if ($transaction['first_step'] == null){
            $step = self::FIRST_STEP;
        }
        else if ($transaction['second_step'] == null){
            $step = self::SECOND_STEP;
        }
        else{
            $step = self::TRANSACTION_FINISHED;
        }
        
        return $step;
    }
    
    public function createRegister($orderId){
        if ($this->getStep($orderId) == self::NEW_ORDER){
            $this->db->query("INSERT INTO ".DB_PREFIX."todopago_transaccion (id_orden) VALUES (".$orderId.")");
            return 1;
        }
        else {
            return 0;
        }
    }
    
    public function recordFirstStep($orderId, $paramsSAR, $responseSAR){
        $datetime = new DateTime('NOW');
        if ($this->getStep($orderId) == self::FIRST_STEP){
            $requestKey = $responseSAR['RequestKey'];
            $publicRequestKey = $responseSAR['PublicRequestKey'];
            $query = "UPDATE ".DB_PREFIX."todopago_transaccion SET first_step = '".$datetime->format("Y-m-d H:i:s")."', params_SAR = '".json_encode($paramsSAR)."', response_SAR = '".json_encode($responseSAR)."', request_key = '".$requestKey."', public_request_key = '".$publicRequestKey."' WHERE id_orden = ".$orderId;
            $this->db->query($query);
            return $query;
        }
        else{
            return 0;
        }
    }
    
    public function recordSecondStep($orderId, $paramsGAA, $responseGAA){
        $datetime = new DateTime('NOW');
        if ($this->getStep($orderId) == self::SECOND_STEP){
            $answerKey = $paramsGAA['AnswerKey'];
            $query = "UPDATE ".DB_PREFIX."todopago_transaccion SET second_step = '".$datetime->format("Y-m-d H:i:s")."', params_GAA = '".json_encode($paramsGAA)."', response_GAA = '".json_encode($responseGAA)."', answer_key = '".$answerKey."' WHERE id_orden = ".$orderId;
            $this->db->query($query);
            return $query;
        }
        else{
            return 0;
        }
    }
    
    
    //No puedo acceder a las constantes, so...
    public function getNewOrder(){
        return self::NEW_ORDER;
    }
    
    public function getFirstStep(){
        return self::FIRST_STEP;
    }
    
    public function getSecondStep(){
        return self::SECOND_STEP;
    }
    
    public function getTransactionFinished(){
        return self::TRANSACTION_FINISHED;
    }
}