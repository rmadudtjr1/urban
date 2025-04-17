package com.test.Urban_Village.reservation.controller;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.test.Urban_Village.accommodation.service.AccommodationService;
import com.test.Urban_Village.admin.service.AdminService;
import com.test.Urban_Village.member.dto.PayDTO;
import com.test.Urban_Village.reservation.service.ReservationService;

@Controller
@RequestMapping("/reservation")
public class ReservationControllerImpl implements ReservationController {

	@Autowired
	ReservationService service;
	@Autowired
	HttpSession session;
	

	@Override
	@RequestMapping("/reservationForm.do")
	public ModelAndView reservationForm(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/reservation/reservationForm"); 
		return mav;
	}

	@Override
	@RequestMapping("/reservation.do")
	public ModelAndView reservation(@ModelAttribute("PayDTO") PayDTO payDTO,
	        HttpServletRequest request, HttpServletResponse response) {

	    ModelAndView mav = new ModelAndView();

	    // 세션 가져오기
	    session = request.getSession(false);
	    if (session == null || session.getAttribute("loginId") == null) {
	        mav.setViewName("redirect:/member/loginForm.do");
	        return mav;
	    }

	    // 세션에서 사용자 ID 가져오기
	    String loginId = (String) session.getAttribute("loginId");
	    payDTO.setId(loginId);
	    System.out.println("=== [예약 컨트롤러 진입] ===");
	    

	    try {
	        // 예약 정보 저장
	        service.addPay(payDTO);
	        // 성공 시 리다이렉트
	        mav.setViewName("redirect:/reservation/reservationHistory.do");
	    } catch (Exception e) {
	        System.out.println("예약 정보 저장 중 오류 발생: " + e.getMessage());
	        e.printStackTrace();
	        
	    }

	    return mav;
	}


	@Override
	@RequestMapping("/reservationHistory.do")
	public ModelAndView reservationHistory(HttpServletRequest request, HttpServletResponse response) {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView();
		session = request.getSession(false);
		if (session == null || session.getAttribute("loginId") == null) {
			mav.setViewName("redirect:/member/loginForm.do");
			System.out.println("로그인되지 않은 사용자");
			return mav;
		}
		String loginId = (String) session.getAttribute("loginId");
		System.out.println("로그인 아이디: " + loginId);
		System.out.println("viewName: " + viewName);

		if (loginId != null) {
			List<PayDTO> userReservations = service.reservationGetUserId(loginId);
			System.out.println("예약 정보: " + userReservations);
			mav.addObject("reservations", userReservations);
			mav.setViewName(viewName);
		}

		return mav;
	}
	@Override
	@RequestMapping("/payList.do")
	public ModelAndView payList(HttpServletRequest request, HttpServletResponse response){
		// TODO Auto-generated method stub
		List<PayDTO> payList = service.payList();
		String viewName = (String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		session.setAttribute("payList", payList);
		for(PayDTO pay : payList) {
			System.out.println(pay);
		}
		return mav;
	}
	@RequestMapping("delReservation")
    public ModelAndView delReservation(@RequestParam("reservation_id") String reservation_id,
                               HttpServletRequest request,
                               HttpServletResponse response) throws IOException {
       int result = service.delReservation(reservation_id);
       response.setContentType("text/html;charset=utf-8");
      PrintWriter out = response.getWriter();
       if(result == 1) {
          out.write("<script>");
         out.write("alert('예약 취소 되었습니다!');");
         out.write("location.href='/Urban_Village/reservation/reservationHistory.do';");
         out.write("</script>");
       }
       return null;
    }
	

}
