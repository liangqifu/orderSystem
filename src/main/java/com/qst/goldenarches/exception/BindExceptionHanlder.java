package com.qst.goldenarches.exception;

import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import com.qst.goldenarches.pojo.Msg;

@RestControllerAdvice
public class BindExceptionHanlder {
	
	@ExceptionHandler(MethodArgumentNotValidException.class)
    public Msg handleBindException(MethodArgumentNotValidException ex) {
		BindingResult bindingResult = ex.getBindingResult();
		FieldError fieldError =  bindingResult.getFieldError();
        StringBuilder sb = new StringBuilder();
        sb.append(fieldError.getField()).append("=[").append(fieldError.getObjectName()).append("]").append(fieldError.getDefaultMessage());
        Msg msg = new Msg();
        msg.setCode(200);
        msg.setMsg(sb.toString());;
        return msg;
    }

}
