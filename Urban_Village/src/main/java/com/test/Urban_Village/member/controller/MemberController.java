package com.test.Urban_Village.member.controller;

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

public interface MemberController {
	public ModelAndView urbanMemberList(HttpServletRequest request, HttpServletResponse response);
	public ModelAndView login(RedirectAttributes rAttr, @RequestParam("id") String id, @RequestParam("pwd") String pwd, HttpServletRequest request, HttpServletResponse response);
	public ModelAndView joinMember(HttpServletRequest request, HttpServletResponse response);
	public ModelAndView loginForm(@RequestParam(value="action", required=false) String action,HttpServletRequest request, HttpServletResponse response);

	public ModelAndView addMember(@ModelAttribute MemberDTO member,HttpServletRequest request, HttpServletResponse response)throws Exception;
	public ModelAndView logout(RedirectAttributes rAttr,HttpServletRequest request, HttpServletResponse response) throws Exception;
	public void checkId(HttpServletRequest request, HttpServletResponse response);
	public ModelAndView reservationForm(HttpServletRequest request, HttpServletResponse response);
	public ModelAndView payList(HttpServletRequest request, HttpServletResponse response);
	//public ModelAndView reservation(String accommodation_id, PayDTO payDTO, HttpServletRequest request,
			//HttpServletResponse response);
	public ModelAndView myInfo(String id, HttpServletRequest request, HttpServletResponse response);
	public ModelAndView updateUserInfo(MemberDTO member, String id, HttpServletRequest request, HttpServletResponse response)
			throws IOException;
	public ModelAndView reservationHistory(HttpServletRequest request, HttpServletResponse response);
	ModelAndView reservation(String accommodation_id, String reservation_id, Date checkin_date, Date checkout_date,
			int guest_count, double total_price, HttpServletRequest request, HttpServletResponse response);
	void deleteMember(String id, String pwd, HttpServletRequest request, HttpServletResponse response)
			throws IOException;
	ModelAndView salesForm(HttpServletRequest request, HttpServletResponse response);
	ModelAndView getDailySales(HttpServletRequest request, HttpServletResponse response);
	ModelAndView getMonthlySales(HttpServletRequest request, HttpServletResponse response);
	ModelAndView getYearlySales(HttpServletRequest request, HttpServletResponse response);
}
