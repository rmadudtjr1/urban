package com.test.Urban_Village.email.controller;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.test.Urban_Village.email.service.MailService;
import com.test.Urban_Village.member.dto.MemberDTO;
import com.test.Urban_Village.member.service.MemberService;

@Controller
@RequestMapping("/email")
public class MailController {
	@Autowired
	MailService service;
	@Autowired
	MemberService memberService;
	
	@RequestMapping("/sendMemberPwd.do")
	public void sendSimpleMail(@RequestParam("member_id")String member_id,@ModelAttribute("MemberDTO")MemberDTO memberDTO,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String email = memberService.findEmailById(member_id);
		//String email= memberDTO.getEmail();
		System.out.println(email);
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		Random random = new Random();
        int number = 1000 + random.nextInt(9000);
        HttpSession session = request.getSession();
        session.setAttribute("pwdCode", number);
        String msg = "<html><body style=\"font-family: sans-serif;\">";
        msg += "<div style=\"background-color: #f7f7f7; padding: 20px; display: flex; justify-content: center;\">";
        msg += "<div style=\"background-color: #fff; border-radius: 8px; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); padding: 30px; text-align: center; width: 90%; max-width: 400px;\">";
        msg += "<h1 style=\"color: #1a73e8; margin-bottom: 20px;\">Urban_Village 비밀번호 찾기</h1>";
        msg += "<div style=\"background-color: #f2f2f2; border-radius: 6px; padding: 20px; margin-bottom: 20px;\">";
        msg += "<span style=\"font-size: 2em; font-weight: bold; color: #333; letter-spacing: 8px;\">" + number + "</span>";
        msg += "</div>";
        msg += "<p style=\"color: #555; line-height: 1.6; margin-bottom: 15px;\">귀하의 이메일 주소로 비밀번호 변경 요청이 있었습니다.</p>";
        msg += "<p style=\"color: #555; line-height: 1.6; margin-bottom: 15px;\">Urban_Village 인증 코드는 위와 같습니다.</p>";
        msg += "<p style=\"color: #555; line-height: 1.6; margin-bottom: 15px;\">만약 이 코드를 요청하지 않으셨다면 다른 사람이 귀하의 계정에 접근하려 시도하는 것일 수 있습니다. 누구에게도 이 코드를 전달하거나 제공하면 안 됩니다.</p>";
        msg += "<p style=\"color: #555; line-height: 1.6; margin-bottom: 20px;\">감사합니다.<br>Urban_Village 팀</p>";
        msg += "</div>";
        msg += "</div>";
        msg += "</body></html>";

        service.sendMail(email, "Urban_Village 비밀번호 찾기 인증 코드", msg);

        out.println("<html><body>");
        out.println("<h3>메일에 전송된 번호 4자리를 입력해 주세요.</h3>");
        out.println("<form action='" + request.getContextPath() + "/member/checkCode.do' method='post'>");
        out.println("<input type='hidden' name='member_id' value='" + member_id + "'/>");
        out.println("<input type='text' name='code' maxlength='4' required>");
        out.println("<button type='submit'>확인</button>");
        out.println("</form>");
        out.println("</body></html>");
    }
}




