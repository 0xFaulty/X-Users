package com.defaulty.xusers.service;

import com.defaulty.xusers.dao.AddressDao;
import com.defaulty.xusers.dao.RoleDao;
import com.defaulty.xusers.model.Address;
import com.defaulty.xusers.model.Role;
import com.defaulty.xusers.model.User;
import com.defaulty.xusers.dao.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userDao;

    @Autowired
    private RoleDao roleDao;

    @Autowired
    private AddressDao addressDao;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Override
    public User findByUsername(String username) {
        return userDao.findByUsername(username);
    }

    @Override
    public void save(User user) {
        this.userDao.save(setDefaultUser(user));
    }

    @Override
    @Transactional
    public void addUser(User user) {
        this.userDao.addUser(setDefaultUser(user));
    }

    private User setDefaultUser(User user) {
        user.setPassword(bCryptPasswordEncoder.encode(user.getNewPassword()));
        Set<Role> roles = new HashSet<>();
        roles.add(roleDao.getOne(1L));
        user.setRoles(roles);

        Set<Address> addresses = new HashSet<>();
        addresses.add(addressDao.getOne(1L));
        user.setAddresses(addresses);

        user.setCreatedTimestamp(new Date());
        user.setLastUpdatedTimestamp(new Date());

        user.setActive(true);

        return user;
    }

    @Override
    @Transactional
    public void updateUser(User user) {
        if (!Objects.equals(user.getNewPassword(), ""))
            user.setPassword(bCryptPasswordEncoder.encode(user.getNewPassword()));

        user.setRoles(findByUsername(user.getUsername()).getRoles());
        user.setAddresses(findByUsername(user.getUsername()).getAddresses());

        user.setLastUpdatedTimestamp(new Date());

        this.userDao.updateUser(user);
    }

    @Override
    @Transactional
    public void removeUser(long id) {
        this.userDao.removeUser(id);
    }

    @Override
    @Transactional
    public User getUserById(long id) {
        return this.userDao.getUserById(id);
    }

    @Override
    @Transactional
    public List<User> listUsers() {
        return this.userDao.listUsers();
    }

    @Override
    @Transactional
    public void activateToggleUser(long id) {
        this.userDao.activateToggleUser(id);
    }

}
