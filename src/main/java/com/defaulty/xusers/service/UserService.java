package com.defaulty.xusers.service;

import com.defaulty.xusers.model.User;

import java.util.List;

public interface UserService {

    void save(User user);

    User findByUsername(String username);

    void addUser(User user);

    void updateUser(User user);

    void removeUser(long id);

    User getUserById(long id);

    List<User> listUsers();

    void activateToggleUser(long id);
}
