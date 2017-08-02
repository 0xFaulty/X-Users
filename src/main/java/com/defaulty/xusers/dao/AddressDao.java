package com.defaulty.xusers.dao;

import com.defaulty.xusers.model.Address;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AddressDao extends JpaRepository<Address, Long> {
}
