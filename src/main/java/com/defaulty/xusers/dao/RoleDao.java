package com.defaulty.xusers.dao;

import com.defaulty.xusers.model.Role;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoleDao extends JpaRepository<Role, Long> {
}
