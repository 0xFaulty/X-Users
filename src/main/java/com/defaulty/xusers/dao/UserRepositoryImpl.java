package com.defaulty.xusers.dao;

import com.defaulty.xusers.model.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

@Repository
public class UserRepositoryImpl implements UserRepositoryCustom {
    private static final Logger logger = LoggerFactory.getLogger(UserRepositoryImpl.class);

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public void addUser(User user) {
        entityManager.persist(user);
        logger.info("User successfully saved. User details: " + user);
    }

    @Override
    public void updateUser(User user) {
        entityManager.merge(user);
        logger.info("User successfully update. User details: " + user);
    }

    @Override
    public void removeUser(long id) {
        User user = entityManager.find(User.class, id);

        if (user != null) {
            entityManager.remove(user);
        }
        logger.info("User successfully removed. User details: " + user);
    }

    @Override
    public User getUserById(long id) {
        User user = entityManager.find(User.class, id);
        logger.info("User successfully loaded. User details: " + user);

        return user;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<User> listUsers() {
        List<User> userList = entityManager.createQuery("from User").getResultList();
        for (User user : userList) {
            logger.info("User list: " + user);
        }

        return userList;
    }

    @Override
    public void activateToggleUser(long id) {
        User user = entityManager.find(User.class, id);
        boolean currentState = user.isActive();
        user.setActive(!currentState);
        entityManager.merge(user);
        logger.info("User active state successfully changed. User details: " + user);
    }
}
