package com.test.Urban_Village;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.test.Urban_Village.accommodation.dto.AccommodationDTO;
import com.test.Urban_Village.accommodation.dto.AccommodationIdDTO;
import com.test.Urban_Village.accommodation.service.AccommodationService;
import com.test.Urban_Village.admin.service.AdminService;
import com.test.Urban_Village.wishList.service.WishListService;

@Controller
public class MainController {
	
	@Autowired
	AccommodationService service;
	@Autowired
	AdminService adminService;
	@Autowired
	WishListService wishListService;

	@RequestMapping(value= {"/", "/main"}) 
	public ModelAndView main(HttpSession session,@ModelAttribute("AccommodationIdDTO") AccommodationIdDTO accIdDTO, @ModelAttribute AccommodationDTO accDTO) {
	    List<AccommodationDTO> accommodationList = service.accList();
	    session.setAttribute("accommodationList", accommodationList);
	    ModelAndView mav = new ModelAndView();
	    List<AccommodationIdDTO> hostBestAccIdList = adminService.accIdListAll(accIdDTO);
	    String memberId = (String) session.getAttribute("loginId");
        if (memberId != null) {
            for (AccommodationDTO acc : accommodationList) {
                boolean liked = wishListService.isLiked(memberId, acc.getAccommodation_id());
                acc.setLiked(liked);  // AccommodationDTO에 setLiked(boolean) 필요
            }
        }
	    mav.addObject("hostBestAccIdList", hostBestAccIdList);
	    mav.setViewName("urbanMain");
	    return mav;
	}

}