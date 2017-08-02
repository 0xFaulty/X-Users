package com.defaulty.xusers.service;

public interface SecurityService {

    String findLoggedInUsername();

    void autoLogin(String username, String password);
}
