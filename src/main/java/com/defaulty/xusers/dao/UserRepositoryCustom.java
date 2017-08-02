package com.defaulty.xusers.dao;

import com.defaulty.xusers.model.User;

import java.util.List;

public interface UserRepositoryCustom {
    void addUser(User user);

    void updateUser(User user);

    void removeUser(long id);

    User getUserById(long id);

    List<User> listUsers();

    void activateToggleUser(long id);
}
