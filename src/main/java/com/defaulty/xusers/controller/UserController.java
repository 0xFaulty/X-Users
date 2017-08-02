package com.defaulty.xusers.controller;

import com.defaulty.xusers.validator.UserValidator;
import com.defaulty.xusers.model.User;
import com.defaulty.xusers.service.SecurityService;
import com.defaulty.xusers.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Objects;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private SecurityService securityService;

    @Autowired
    private UserValidator userValidator;

    @RequestMapping(value = "/registration", method = RequestMethod.GET)
    public String registration(Model model) {
        model.addAttribute("userForm", new User());

        return "registration";
    }

    @RequestMapping(value = "/registration", method = RequestMethod.POST)
    public String registration(@ModelAttribute("userForm") User userForm, BindingResult bindingResult, Model model) {
        userValidator.validate(userForm, bindingResult);

        if (bindingResult.hasErrors()) {
            return "registration";
        }

        userService.save(userForm);

        securityService.autoLogin(userForm.getUsername(), userForm.getConfirmPassword());

        return "redirect:/welcome";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login(Model model, String error, String logout) {

        model.addAttribute("userForm", new User());

        if (error != null) {
            if (Objects.equals(error, ""))
                model.addAttribute("error", "Username or password is incorrect.");
            else
                model.addAttribute("error", error);
        }

        if (logout != null) {
            model.addAttribute("message", "Logged out successfully.");
        }

        return "login";
    }

    @RequestMapping(value = {"/", "/welcome"}, method = RequestMethod.GET)
    public String welcome(Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        String username;
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        } else {
            username = principal.toString();
        }

        if (username != null && !userValidator.validateActivity(username)) {
            model.addAttribute("error", "Your account was blocked.");
            return "redirect:/login";
        }

        return "welcome";
    }

    @RequestMapping(value = "admin", method = RequestMethod.GET)
    public String listUsers(Model model) {
        model.addAttribute("adminEditForm", new User());
        model.addAttribute("listUsers", this.userService.listUsers());

        return "admin";
    }

    @RequestMapping(value = "/admin/add", method = RequestMethod.POST)
    public String addUser(@ModelAttribute("adminEditForm") User adminEditForm, BindingResult bindingResult, Model model) {

        model.addAttribute("listUsers", this.userService.listUsers());

        userValidator.validateAttributes(adminEditForm, bindingResult);

        if (adminEditForm.getId() == null) {
            userValidator.validateUsername(adminEditForm, bindingResult);
            userValidator.validateNewPassword(adminEditForm, bindingResult);
        }

        if (bindingResult.hasErrors()) {
            return "admin";
        }

        if (adminEditForm.getNewPassword().equals(""))
            adminEditForm.setPassword(this.userService.findByUsername(adminEditForm.getUsername()).getPassword());

        if (adminEditForm.getId() == null) {
            this.userService.addUser(adminEditForm);
        } else {
            this.userService.updateUser(adminEditForm);
        }

        return "redirect:/admin";
    }

    @RequestMapping("/admin/remove/{id}")
    public String removeUser(@PathVariable("id") int id) {
        this.userService.removeUser(id);

        return "redirect:/admin";
    }

    @RequestMapping("/admin/edit/{id}")
    public String editUser(@PathVariable("id") int id, Model model) {
        User user = this.userService.getUserById(id);
        if (user.isActive()) {
            DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
            user.setBirthdayString(df.format(user.getBirthday()));
            model.addAttribute("adminEditForm", user);
        }
        else
            model.addAttribute("adminEditForm", new User());

        model.addAttribute("listUsers", this.userService.listUsers());

        return "admin";
    }

    @RequestMapping("/admin/addresses/{id}")
    public String addressUser(@PathVariable("id") int id, Model model) {
        model.addAttribute("setAddresses", this.userService.getUserById(id).getAddresses().toArray());

        return "addresses";
    }

    @RequestMapping("/admin/activetoggle/{id}")
    public String activeUser(@PathVariable("id") int id, Model model) {
        this.userService.activateToggleUser(id);

        return "redirect:/admin";
    }

}
