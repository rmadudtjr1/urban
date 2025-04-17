package com.test.Urban_Village.reservation.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.test.Urban_Village.member.dto.MemberDTO;
import com.test.Urban_Village.member.dto.PayDTO;

public interface ReservationController {
	
	public ModelAndView reservationForm(HttpServletRequest request, HttpServletResponse response);
	public ModelAndView payList(HttpServletRequest request, HttpServletResponse response);
	public ModelAndView reservationHistory(HttpServletRequest request, HttpServletResponse response);
	ModelAndView reservation(PayDTO paydto, HttpServletRequest request, HttpServletResponse response);
}
