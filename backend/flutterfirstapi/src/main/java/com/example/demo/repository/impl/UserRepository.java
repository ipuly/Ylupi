package com.example.demo.repository.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.example.demo.model.UserModel;
import com.example.demo.repository.IUserRepository;

@Repository
public class UserRepository implements IUserRepository {

    @Autowired
    JdbcTemplate jdbcTemplate;

    @Override
    public UserModel insertUser(UserModel user) {
        String query = "INSERT INTO tb_user(name, email, gender) "
                + "VALUES(?, ?, ?)";
        jdbcTemplate.update(query, new Object[] { user.getName(), user.getEmail(), user.getGender() });
        return user;
    }

    @Override
    public List<UserModel> getAllUser() {
        String query = "SELECT * FROM tb_user";
        return jdbcTemplate.query(query, new BeanPropertyRowMapper<>(UserModel.class));
    }

    @Override
    public UserModel updateUser(int id, UserModel user) {
        String query = "UPDATE tb_user SET name = ?, email = ?, gender = ? WHERE id = ?";

        jdbcTemplate.update(query, new Object[] { user.getName(), user.getEmail(), user.getGender(), id });

        return user;
    }

    @Override
    public UserModel deleteUser(int id) {
        String query = "SELECT * FROM tb_user WHERE id = ?";
        var result = jdbcTemplate.queryForObject(query, new BeanPropertyRowMapper<>(UserModel.class), id);

        query = "DELETE FROM tb_user WHERE id = ?";
        jdbcTemplate.update(query, id);

        return result;
    }

}
