package com.test.Urban_Village.review.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.test.Urban_Village.review.dto.ReviewDTO;
import com.test.Urban_Village.review.service.ReviewService;

@Controller
@RequestMapping("/review")
public class ReviewControllerImpl implements ReviewController {

    @Autowired
    ReviewService service;

    @Autowired
    HttpSession session;

    private static final String TEMP_DIR = "D:\\image\\reviewTemp\\";
    private static final String DEST_DIR = "D:\\image\\reviewImage\\";

    /**
     * 후기 작성 페이지 이동
     */
    @RequestMapping("/write")
    public String writeReview(@RequestParam("reservation_id") int reservationId,
                              @RequestParam(value = "accommodation_name", required = false) String accommodationName,
                              @RequestParam("accommodation_id") String accommodationId,
                              Model model) {
        model.addAttribute("reservation_id", reservationId);
        model.addAttribute("accommodation_name", accommodationName);
        model.addAttribute("accommodation_id", accommodationId);

        System.out.println("Reservation ID: " + reservationId);
        System.out.println("Accommodation Name: " + accommodationName); // 디버깅
        System.out.println("Accommodation Name: " + accommodationId); // 디버깅
        return "reservation/reviewWrite";
    }

    /**
     * 후기 저장
     */
    
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public ResponseEntity<String> reviewSave(
    		@RequestParam("accommodation_id") String accommodationId,
    		@RequestParam("accommodation_name") String accommodationName,
    		MultipartHttpServletRequest mRequest, HttpServletResponse response) throws Exception {
        mRequest.setCharacterEncoding("utf-8");
        Map<String, Object> reviewMap = new HashMap<>();
        Enumeration<String> enu = mRequest.getParameterNames();

        while (enu.hasMoreElements()) {
            String name = enu.nextElement();
            String value = mRequest.getParameter(name);
            reviewMap.put(name, value);
        }

        // 다중 이미지 처리
        List<MultipartFile> mFiles = mRequest.getFiles("review_photo[]");
        List<String> fileList = new ArrayList<>();
        for (MultipartFile mFile : mFiles) {
            if (!mFile.isEmpty()) {
                String originalFileName = mFile.getOriginalFilename();
                fileList.add(originalFileName);

                File file = new File(TEMP_DIR + originalFileName);
                mFile.transferTo(file);
            }
        }

        // 파일 이름 저장
        reviewMap.put("review_photo", String.join(",", fileList));
        
        HttpSession session = mRequest.getSession();
        String id = (String) session.getAttribute("loginId");
        reviewMap.put("id", id);

        // 숙소 관련 정보 가져오기

        String redirectUrl = mRequest.getContextPath() + "/accommodation/accommodationPage.do?accommodation_id=" + accommodationId + "&accommodation_name=" + accommodationName;

        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.add("Content-Type", "text/html;charset=utf-8");

        try {
            // 리뷰 저장 및 reviewId 가져오기
            String reviewId = service.addReviewAndGetId(reviewMap);

            // TEMP_DIR에서 DEST_DIR로 파일 이동
            File destDir = new File(DEST_DIR + reviewId);
            if (!destDir.exists()) {
                destDir.mkdirs();
            }
            for (String fileName : fileList) {
                File srcFile = new File(TEMP_DIR + fileName);
                FileUtils.moveFileToDirectory(srcFile, destDir, true);
            }

            // 성공 메시지 및 리다이렉트
            String message = "<script>";
            message += "alert('후기가 성공적으로 저장되었습니다.');";
            message += "location.href='" + redirectUrl + "';";
            message += "</script>";
            return new ResponseEntity<>(message, responseHeaders, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();

            // TEMP_DIR 파일 삭제
            for (String fileName : fileList) {
                File srcFile = new File(TEMP_DIR + fileName);
                srcFile.delete();
            }

            // 실패 메시지
            String message = "<script>";
            message += "alert('오류가 발생했습니다. 다시 시도해주세요.');";
            message += "location.href='" + mRequest.getContextPath() + "/review/write';";
            message += "</script>";
            return new ResponseEntity<>(message, responseHeaders, HttpStatus.BAD_REQUEST);
        }
    }
   
    
    public void reviewRating(@ModelAttribute("ReviewDTO") ReviewDTO reviewDTO ,HttpServletRequest request, HttpServletResponse response) {
    	
    }
    
}