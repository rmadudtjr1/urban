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

import com.test.Urban_Village.member.dto.MemberDTO;
import com.test.Urban_Village.member.service.MemberService;
import com.test.Urban_Village.reservation.dto.PayDTO;
import com.test.Urban_Village.reservation.service.ReservationService;

@Controller
@RequestMapping("/reservation")
public class ReservationControllerImpl implements ReservationController {

    @Autowired
    ReservationService service;
    
    @Autowired
    MemberService mService;

    @Autowired
    HttpSession session;

    @Override
    @RequestMapping("/reservationForm.do")
    public ModelAndView reservationForm(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView();
        // 세션에서 로그인된 사용자 ID 가져오기
        String loginId = (String) session.getAttribute("loginId");
        if (loginId == null) {
            // 로그인 안되어 있으면 로그인 페이지로 리다이렉트
            mav.setViewName("redirect:/member/loginForm.do");
            return mav;
        }

        // 쿠폰 리스트 조회 (서비스 계층에서 가져옴)
        List<MemberDTO> couponList = mService.getCouponsByMemberId(loginId);

        mav.addObject("couponList", couponList);
        mav.setViewName("/reservation/reservationForm");
        return mav;
    }

    @Override
    @RequestMapping("/reservation.do")
    public ModelAndView reservation(@ModelAttribute("PayDTO") PayDTO payDTO,
                            @ModelAttribute("MemberDTO") MemberDTO memberDTO,
                                     HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView();

        // 세션에서 사용자 ID 가져오기
        session = request.getSession(false);
        if (session == null || session.getAttribute("loginId") == null) {
            mav.setViewName("redirect:/member/loginForm.do");
            return mav;
        }

        String loginId = (String) session.getAttribute("loginId");
        payDTO.setId(loginId); // 사용자 ID 설정



        try {
            
         // 쿠폰 사용 체크: 쿠폰 ID가 존재하면 쿠폰 상태 업데이트
            if (memberDTO.getCoupon_id() != null && !memberDTO.getCoupon_id().isEmpty()) {
               payDTO.setCoupon_id(memberDTO.getCoupon_id()); // ✅ 쿠폰 ID 꼭 저장
                // available 상태에서 사용되었음을 나타내기 위해 'Y'에서 'N'으로 변경
                mService.updateCouponStatus(memberDTO.getCoupon_id());
                
            }
         // 예약 정보 저장
            service.addPay(payDTO);
            // 성공 시 리다이렉트
            mav.setViewName("redirect:/reservation/reservationHistory.do");
        } catch (Exception e) {
            e.printStackTrace();
        }

        return mav;
    }

    @Override
    @RequestMapping("/reservationHistory.do")
    public ModelAndView reservationHistory(@ModelAttribute("PayDTO") PayDTO payDTO,
                                           HttpServletRequest request, HttpServletResponse response) {
        String viewName = (String) request.getAttribute("viewName");
        ModelAndView mav = new ModelAndView();

        // 세션 확인 및 로그인 여부 확인
        session = request.getSession(false);
        if (session == null || session.getAttribute("loginId") == null) {
            mav.setViewName("redirect:/member/loginForm.do");
            return mav;
        }

        String loginId = (String) session.getAttribute("loginId");

        if (loginId != null) {
            // 1. 예약 내역 가져오기
            List<PayDTO> userReservations = service.reservationGetUserId(loginId);

            // 2. 쿠폰 정보 가져오기
            List<MemberDTO> couponList = mService.getCouponsByMemberId1(loginId);
            // 3. 예약마다 쿠폰 정보 매핑
            for (PayDTO reservation : userReservations) {
                String resCouponId = reservation.getCoupon_id();
                System.out.println("예약별 쿠폰ID: " + resCouponId); // 요걸로 찍어야 확인 가능
                if (resCouponId != null && !resCouponId.isEmpty()) {
                    for (MemberDTO coupon : couponList) {
                        if (resCouponId.equals(coupon.getCoupon_id())) {
                            reservation.setCoupon_name(coupon.getCoupon_name());
                            reservation.setDiscount(coupon.getDiscount());
                            break;
                        }
                    }
                }
            }


            mav.addObject("reservations", userReservations);

            // 쿠폰 리스트도 따로 넘길 수도 있음
            mav.addObject("couponList", couponList);

            mav.setViewName(viewName);  // ex: /reservation/reservationHistory.jsp
        }

        return mav;
    }

    

    @Override
    @RequestMapping("/payList.do")
    public ModelAndView payList(HttpServletRequest request, HttpServletResponse response) {
        List<PayDTO> payList = service.payList();
        String viewName = (String) request.getAttribute("viewName");
        ModelAndView mav = new ModelAndView(viewName);
        session.setAttribute("payList", payList);

        for (PayDTO pay : payList) {
            System.out.println(pay);
        }

        return mav;
    }
    
    @RequestMapping("delReservation")
    public ModelAndView delReservation(@RequestParam("reservation_id") String reservation_id,
                               @ModelAttribute("MemberDTO") MemberDTO memberDTO,
                               HttpServletRequest request,
                               HttpServletResponse response) throws IOException {
       
       response.setContentType("text/html;charset=utf-8");
      PrintWriter out = response.getWriter();
       System.out.println("쿠폰아이디 :"+memberDTO.getCoupon_id());
       if(memberDTO.getCoupon_id()!=null) {
          int result1 = mService.modCoupon(memberDTO.getCoupon_id());
          if(result1 == 1) {
             out.write("<script>");
             out.write("alert('사용하신 쿠폰을 회원님 계정에 재발급되었습니다!');");
             out.write("</script>");
           }
       }
       
       int result = service.delReservation(reservation_id);
       if(result == 1) {
          out.write("<script>");
         out.write("alert('예약 취소 되었습니다!');");
         out.write("location.href='/Urban_Village/reservation/reservationHistory.do';");
         out.write("</script>");
       }
       return null;
    }
        
}