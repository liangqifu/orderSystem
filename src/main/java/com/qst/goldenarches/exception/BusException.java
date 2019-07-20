package com.qst.goldenarches.exception;

public class BusException extends Exception {
	
	private Integer errorCode = 200;
	private String errorMsg;
	private static final long serialVersionUID = -5238342980404829829L;

	public BusException() {
		super();
	}
	
	public BusException(Integer errorCode,String message) {
		super(message);
		this.errorMsg = message;
		this.errorCode = errorCode;
	}
	
	public BusException(String message) {
		super(message);
		this.errorMsg = message;
	}

	public BusException(Throwable cause) {
		super(cause);
	}
	
	public BusException(Integer errorCode,String message, Throwable cause) {
		super(message, cause);
		this.errorMsg = message;
		this.errorCode = errorCode;
	}
	
	public BusException(String message, Throwable cause) {
		super(message, cause);
		this.errorMsg = message;
	}

	public BusException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
		this.errorMsg = message;
	}

	public Integer getErrorCode() {
		return errorCode;
	}

	public void setErrorCode(Integer errorCode) {
		this.errorCode = errorCode;
	}

	public String getErrorMsg() {
		return errorMsg;
	}

	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}
	
	
}
