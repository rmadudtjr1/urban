/*
 * package com.test.Urban_Village.accommodation.controller;
 * 
 * import java.io.File; import java.io.IOException; import java.io.PrintWriter;
 * import java.util.ArrayList; import java.util.Enumeration; import
 * java.util.HashMap; import java.util.List; import java.util.Map;
 * 
 * import javax.servlet.http.HttpServletRequest; import
 * javax.servlet.http.HttpServletResponse; import
 * javax.servlet.http.HttpSession;
 * 
 * import org.apache.commons.io.FileUtils; import
 * org.springframework.beans.factory.annotation.Autowired; import
 * org.springframework.http.HttpHeaders; import
 * org.springframework.http.HttpStatus; import
 * org.springframework.http.ResponseEntity; import
 * org.springframework.stereotype.Controller; import
 * org.springframework.web.bind.annotation.ModelAttribute; import
 * org.springframework.web.bind.annotation.RequestMapping; import
 * org.springframework.web.bind.annotation.RequestMethod; import
 * org.springframework.web.bind.annotation.RequestParam; import
 * org.springframework.web.bind.annotation.ResponseBody; import
 * org.springframework.web.multipart.MultipartFile; import
 * org.springframework.web.multipart.MultipartHttpServletRequest; import
 * org.springframework.web.servlet.ModelAndView;
 * 
 * import com.test.Urban_Village.accommodation.dto.AccommodationDTO; import
 * com.test.Urban_Village.accommodation.service.AccommodationService; import
 * com.test.Urban_Village.member.dto.MemberDTO;
 * 
 * @Controller
 * 
 * @RequestMapping("/accommodation") public class AccommodationControllerImpl
 * implements AccommodationController {
 * 
 * @Autowired AccommodationService service;
 * 
 * @Autowired HttpSession session;
 * 
 * private static final String TEMP_DIR = "D:\\image\\temp\\"; private static
 * final String DEST_DIR = "D:\\image\\addImage\\";
 * 
 * @Override
 * 
 * @RequestMapping("/accommodationPage.do") public ModelAndView
 * accommodationPage (@RequestParam("accommodation_id")String accommodation_id,
 * HttpServletResponse response, HttpServletRequest request) { ModelAndView mav
 * = new ModelAndView(); System.out.println("아이디 가져온거 출력" + accommodation_id);
 * //String viewName = (String)request.getAttribute("viewName");
 * //mav.setViewName(viewName); String viewName =
 * (String)request.getAttribute("viewName"); mav.setViewName(viewName);
 * //mav.setViewName("accommodation/accommodationPage");
 * 
 * System.out.println(viewName);
 * 
 * AccommodationDTO accommodation =
 * service.findAccommodationId(accommodation_id);
 * session.setAttribute("accommodation", accommodation); List<AccommodationDTO>
 * accList = service.accList(); System.out.println("아이디 갯수: " + accList.size());
 * //아이디 갯수 보려고 적어둔거 
 * 
 * System.out.println(accommodation.getPrice()); for (AccommodationDTO acc :
 * accList) { System.out.println(acc); } return mav; }
 * 
 * @Override
 * 
 * @RequestMapping("/accommodationForm.do") public ModelAndView
 * accommodationForm(HttpServletResponse response, HttpServletRequest request) {
 * ModelAndView mav = new ModelAndView(); String viewName =
 * (String)request.getAttribute("viewName"); mav.setViewName(viewName);
 * System.out.println("viewName : " + viewName); return mav; }
 * 
 * @Override
 * 
 * @RequestMapping("/accommodation.do") public ModelAndView
 * accommodation(@ModelAttribute("dto") AccommodationDTO dto,
 * HttpServletResponse response, HttpServletRequest request) throws IOException
 * { ModelAndView mav = new ModelAndView(); String viewName = (String)
 * request.getAttribute("viewName"); String generatedId =
 * service.addAccommodation(dto); boolean isSuccess = (generatedId != null &&
 * !generatedId.isEmpty());
 * 
 * //이거 알러트로 뜨는 건데 나중에 다 모달로 바꿔야 PrintWriter out = response.getWriter();
 * 
 * if (isSuccess) { out.write("alert('회원 가입이 성공적으로 완료되었습니다. ID: " + generatedId
 * + "');"); } else { out.write("alert('회원 가입에 실패했습니다.');"); }
 * out.write("location.href='accommodationList.do';"); // 가입 완료 후 숙소 목록 페이지로 이동
 * out.write("</script>"); mav.setViewName("urbanMain"); return mav;
 * 
 * }
 * 
 * @Override
 * 
 * @RequestMapping(value = "/addNewAccommodation", method = RequestMethod.POST)
 * public ResponseEntity<String> addNewAccommodation(MultipartHttpServletRequest
 * mRequest, HttpServletResponse response) throws Exception {
 * mRequest.setCharacterEncoding("utf-8"); Map<String, Object> accommodationMap
 * = new HashMap<>(); Enumeration<String> enu = mRequest.getParameterNames();
 * 
 * while (enu.hasMoreElements()) { String name = enu.nextElement(); String value
 * = mRequest.getParameter(name); accommodationMap.put(name, value); }
 * 
 * // 다중 이미지 파일에 대해 getFiles() 메서드를 사용하여 모두 받아옴 List<MultipartFile> mFiles =
 * mRequest.getFiles("accommodation_photo[]"); List<String> fileList = new
 * ArrayList<>(); if (mFiles != null && !mFiles.isEmpty()){ for(MultipartFile
 * mFile : mFiles) { if(mFile != null && !mFile.isEmpty()){ String
 * originalFileName = mFile.getOriginalFilename();
 * fileList.add(originalFileName);
 * 
 * File file = new File(TEMP_DIR + originalFileName); if (!file.exists()) { if
 * (file.getParentFile().mkdirs()) { file.createNewFile(); } }
 * mFile.transferTo(file); } } }
 * 
 * if (fileList != null && !fileList.isEmpty()) { String fileNames =
 * String.join(",", fileList); accommodationMap.put("accommodation_photo",
 * fileNames); }
 * 
 * HttpSession session = mRequest.getSession(); String id = (String)
 * session.getAttribute("loginId"); accommodationMap.put("id", id);
 * 
 * String message; ResponseEntity<String> resEnt; HttpHeaders responseHeaders =
 * new HttpHeaders(); responseHeaders.add("Content-Type",
 * "text/html;charset=utf-8");
 * 
 * try { // DB에 다중 이미지 파일명(콤마 구분 문자열)을 저장 String accommodationId =
 * service.addNewAccommodation(accommodationMap); // TEMP_DIR에서 모든 파일을
 * DEST_DIR/accommodationId 폴더로 이동 if (fileList != null && !fileList.isEmpty())
 * { for(String fileName : fileList) { File srcFile = new File(TEMP_DIR +
 * fileName); File destDir = new File(DEST_DIR + accommodationId);
 * FileUtils.moveFileToDirectory(srcFile, destDir, true); } }
 * 
 * message = "<script>"; message += "alert('숙소 등록이 성공적으로 완료되었습니다. ID: " +
 * accommodationId + "');"; message += "location.href='" +
 * mRequest.getContextPath() + "/accommodation/main.do';"; message +=
 * "</script>"; resEnt = new ResponseEntity<>(message, responseHeaders,
 * HttpStatus.OK); } catch (Exception e) { if (fileList != null &&
 * !fileList.isEmpty()) { for (String fileName : fileList) { File srcFile = new
 * File(TEMP_DIR + fileName); srcFile.delete(); } } message = "<script>";
 * message += "alert('오류가 발생했습니다. 다시 시도해 주세요');"; message += "location.href='" +
 * mRequest.getContextPath() + "/accommodation/accommodationForm.do';"; message
 * += "</script>"; resEnt = new ResponseEntity<>(message, responseHeaders,
 * HttpStatus.CREATED); } return resEnt; }
 * 
 * @Override
 * 
 * @RequestMapping(value = "/accommodationPage", method = RequestMethod.GET)
 * public ModelAndView accommodationPage(@RequestParam("accommodation_id")
 * String accommodationId) { AccommodationDTO accommodation =
 * service.findAccommodationId(accommodationId); ModelAndView mav = new
 * ModelAndView("accommodation/accommodationPage");
 * mav.addObject("accommodation", accommodation); return mav; }
 * 
 * @Override
 * 
 * @RequestMapping("/main.do") public ModelAndView main(HttpServletResponse
 * response, HttpServletRequest request) { ModelAndView mav = new
 * ModelAndView(); List<AccommodationDTO> accommodationList = service.accList();
 * mav.addObject("accommodationList", accommodationList);
 * mav.setViewName("urbanMain"); return mav; }
 * 
 * @Override
 * 
 * @RequestMapping("/accommodationList.do") public ModelAndView
 * accommodationList(HttpServletResponse response, HttpServletRequest request) {
 * String viewName = (String) request.getAttribute("viewName"); ModelAndView mav
 * = new ModelAndView(); List<AccommodationDTO> accommodationList =
 * service.accList(); mav.addObject("accommodationList",accommodationList);
 * mav.setViewName("admin/accommodationList"); return mav; }
 * 
 * @Override
 * 
 * @RequestMapping("/delAccommodation.do") public ModelAndView
 * delAccommodation(@RequestParam("accommodation_id")String
 * accommodation_id,HttpServletResponse response, HttpServletRequest request)
 * throws IOException { int result = service.delAccommodation(accommodation_id);
 * response.setContentType("text/html;charset=utf-8"); PrintWriter out =
 * response.getWriter();
 * 
 * if (result == 1) { out.write("<script>");
 * out.write("alert('숙소 삭제에 성공했습니다!');"); out.write(
 * "location.href='/Urban_Village/accommodation/accommodationList.do';");
 * out.write("</script>"); } else { out.write("<script>");
 * out.write("alert('숙소  삭제에 실패했습니다.');"); out.write(
 * "location.href='/Urban_Village/accommodation/accommodationList.do';");
 * out.write("</script>"); } return null;
 * 
 * }
 * 
 * 
 * //@Override
 * 
 * @RequestMapping("/modAccommodationForm.do") public ModelAndView
 * modAccommodationForm(@ModelAttribute("AccommodationDTO")AccommodationDTO
 * accDTO,@RequestParam("accommodation_id")String
 * accommodation_id,HttpServletResponse response, HttpServletRequest request)
 * throws IOException { ModelAndView mav = new ModelAndView(); String viewName =
 * (String) request.getAttribute("viewName"); AccommodationDTO result =
 * service.findAccommodationId(accommodation_id);
 * response.setContentType("text/html;charset=utf-8"); PrintWriter out =
 * response.getWriter(); if (result == 1) { mav.setViewName(viewName);
 * out.write("<script>"); out.write("alert('수정성공!');");
 * out.write("location.href='" + request.getContextPath() +
 * "/accommodationList.do';"); out.write("</script>"); } else {
 * out.write("<script>"); out.write("alert('수정실패');");
 * out.write("location.href='" + request.getContextPath() +
 * "/accommodationList.do';"); out.write("</script>"); } return mav;
 * 
 * }
 */

package com.test.Urban_Village.accommodation.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.test.Urban_Village.accommodation.dto.AccommodationDTO;
import com.test.Urban_Village.accommodation.service.AccommodationService;
import com.test.Urban_Village.review.dto.ReviewDTO;
import com.test.Urban_Village.review.service.ReviewService;

@Controller
@RequestMapping("/accommodation")
public class AccommodationControllerImpl implements AccommodationController {
	@Autowired
	AccommodationService service;
	@Autowired
	HttpSession session;
	@Autowired
	ReviewService rService;

	private static final String TEMP_DIR = "D:\\image\\temp\\";
	private static final String DEST_DIR = "D:\\image\\addImage\\";
	private static final String ACCOMMODATION_IMAGE_REPO = "D:\\image\\addImage\\"; // 업데이트 시 이미지 저장 경로

	@Override
	@RequestMapping("/accommodationPage.do")
	public ModelAndView accommodationPage(@RequestParam("accommodation_name")String accommodationName,@RequestParam("accommodation_id") String accommodation_id, HttpServletResponse response, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String viewName = (String) request.getAttribute("viewName");
		mav.setViewName(viewName);

		AccommodationDTO accommodation = service.findAccommodationId(accommodation_id);
		session.setAttribute("accommodation", accommodation);
		try {
			List<ReviewDTO> reviews = rService.getReviewsByAccommodationId(accommodationName);
			if (reviews == null || reviews.isEmpty()) {
				System.out.println("No reviews found for accommodation: " + accommodationName);
			} else {
				System.out.println("Fetched reviews: " + reviews);
			}
			System.out.println("Fetched reviews: " + reviews); // 디버깅 로그 추가
			mav.addObject("reviews", reviews);
		} catch (Exception e) {
			System.out.println("Error fetching reviews: " + e.getMessage());
			e.printStackTrace();
		}
		return mav;
	}

	@Override
	@RequestMapping("/accommodationForm.do")
	public ModelAndView accommodationForm(HttpServletResponse response, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String viewName = (String) request.getAttribute("viewName");
		mav.setViewName(viewName);
		return mav;
	}

	/*
	 * @Override
	 * 
	 * @RequestMapping("/accommodation.do") public ModelAndView
	 * accommodation(@ModelAttribute("dto") AccommodationDTO dto,
	 * HttpServletResponse response, HttpServletRequest request) throws IOException
	 * { ModelAndView mav = new ModelAndView(); String viewName = (String)
	 * request.getAttribute("viewName"); String generatedId =
	 * service.addAccommodation(dto); boolean isSuccess = (generatedId != null &&
	 * !generatedId.isEmpty());
	 * 
	 * PrintWriter out = response.getWriter();
	 * 
	 * if (isSuccess) { out.write("<script>alert('숙소 등록이 성공적으로 완료되었습니다. ID: " +
	 * generatedId + "'); location.href='accommodationList.do';</script>"); } else {
	 * out.
	 * write("<script>alert('숙소 등록에 실패했습니다.'); location.href='accommodationForm.do';</script>"
	 * ); } mav.setViewName("urbanMain"); return mav; }
	 */

	@Override
	@RequestMapping(value = "/addNewAccommodation", method = RequestMethod.POST)
	public ResponseEntity<String> addNewAccommodation(MultipartHttpServletRequest mRequest, HttpServletResponse response) throws Exception {
		mRequest.setCharacterEncoding("utf-8");
		Map<String, Object> accommodationMap = new HashMap<>();
		Enumeration<String> enu = mRequest.getParameterNames();

		while (enu.hasMoreElements()) {
			String name = enu.nextElement();
			String value = mRequest.getParameter(name);
			accommodationMap.put(name, value);
		}

		List<MultipartFile> mFiles = mRequest.getFiles("accommodation_photo[]");
		List<String> fileList = new ArrayList<>();
		if (mFiles != null && !mFiles.isEmpty()) {
			for (MultipartFile mFile : mFiles) {
				if (mFile != null && !mFile.isEmpty()) {
					String originalFileName = mFile.getOriginalFilename();
					fileList.add(originalFileName);

					File file = new File(TEMP_DIR + originalFileName);
					if (!file.exists()) {
						if (file.getParentFile().mkdirs()) {
							file.createNewFile();
						}
					}
					mFile.transferTo(file);
				}
			}
		}

		if (fileList != null && !fileList.isEmpty()) {
			String fileNames = String.join(",", fileList);
			accommodationMap.put("accommodation_photo", fileNames);
		}

		String id = (String) session.getAttribute("loginId");
		accommodationMap.put("id", id);

		String message;
		ResponseEntity<String> resEnt;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html;charset=utf-8");

		try {
			String accommodationId = service.addNewAccommodation(accommodationMap);
			if (fileList != null && !fileList.isEmpty()) {
				File destDir = new File(DEST_DIR + accommodationId);
				destDir.mkdirs(); // Ensure destination directory exists
				for (String fileName : fileList) {
					File srcFile = new File(TEMP_DIR + fileName);
					FileUtils.moveFileToDirectory(srcFile, destDir, true);
				}
			}

			message = "<script>alert('숙소 등록이 성공적으로 완료되었습니다. ID: " + accommodationId + "'); location.href='" + mRequest.getContextPath() + "/accommodation/main.do';</script>";
			resEnt = new ResponseEntity<>(message, responseHeaders, HttpStatus.OK);
		} catch (Exception e) {
			if (fileList != null && !fileList.isEmpty()) {
				for (String fileName : fileList) {
					File srcFile = new File(TEMP_DIR + fileName);
					srcFile.delete();
				}
			}
			message = "<script>alert('오류가 발생했습니다. 다시 시도해 주세요'); location.href='" + mRequest.getContextPath() + "/accommodation/accommodationForm.do';</script>";
			resEnt = new ResponseEntity<>(message, responseHeaders, HttpStatus.CREATED);
			e.printStackTrace();
		}
		return resEnt;
	}



	@Override
	@RequestMapping(value= {"/", "/main"})
	public ModelAndView main(HttpServletResponse response, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		List<AccommodationDTO> accommodationList = service.accList();
		mav.addObject("accommodationList", accommodationList);

		mav.setViewName("urbanMain");
		return mav;
	}


	@Override
	@RequestMapping("/accommodationList.do") 
	public ModelAndView modAccommodationList(HttpServletResponse response, HttpServletRequest request) {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(); List<AccommodationDTO> accommodationList =
				service.accList(); mav.addObject("accommodationList", accommodationList);
				session.setAttribute("accommodationList", accommodationList);
				mav.setViewName("admin/accommodationList"); 
				return mav; 
	}

	/*
	 * @Override
	 * 
	 * @RequestMapping("/accommodationList.do") public String
	 * accommodationList(Model model) { // 숙소 목록을 조회 List<AccommodationDTO> accList
	 * = service.accList(); // 각 숙소에 대해 평균 평점 설정 for (AccommodationDTO acc :
	 * accList) { System.out.println("숙소 아이디: " + acc.getAccommodation_id()); Double
	 * avgRating =
	 * rService.getAverageRatingByAccommodationId(acc.getAccommodation_id()); if
	 * (avgRating == null) { avgRating = 0.0; } acc.setAverageRating(avgRating); }
	 * 
	 * // 모델에 숙소 목록 추가 model.addAttribute("accommodationList", accList); return
	 * "accommodationListPage"; }
	 */

	@Override
	@RequestMapping("/delAccommodation.do")
	public ModelAndView delAccommodation(@RequestParam("accommodation_id") String accommodation_id, HttpServletResponse response, HttpServletRequest request) throws IOException {
		int result = service.delAccommodation(accommodation_id);
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();

		if (result == 1) {
			out.write("<script>alert('숙소 삭제에 성공했습니다!'); location.href='/Urban_Village/accommodation/accommodationList.do';</script>");
		} else {
			out.write("<script>alert('숙소 삭제에 실패했습니다.'); location.href='/Urban_Village/accommodation/accommodationList.do';</script>");
		}
		return null;
	}

	@RequestMapping("/modAccommodationForm.do")
	public ModelAndView modAccommodationForm(@ModelAttribute("AccommodationDTO")AccommodationDTO accDTO,@RequestParam("accommodation_id") String accommodation_id, HttpServletResponse response, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String viewName = (String) request.getAttribute("viewName");
		AccommodationDTO accommodation = service.findAccommodationId(accommodation_id);
		mav.addObject("accommodation", accommodation);
		mav.setViewName(viewName);
		return mav;
	}


	@RequestMapping(value = "/accommodationUpdate.do", method = RequestMethod.POST)
	public ResponseEntity<String> updateAccommodation(MultipartHttpServletRequest multipartRequest,
			HttpServletResponse response, HttpServletRequest request) throws Exception {
		multipartRequest.setCharacterEncoding("utf-8");
		Map<String, Object> accommodationMap = new HashMap<>();
		ResponseEntity<String> resEntity = null;
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "text/html; charset=utf-8");

		try {
			Enumeration<String> enu = multipartRequest.getParameterNames();
			while (enu.hasMoreElements()) {
				String name = enu.nextElement();
				String value = multipartRequest.getParameter(name);
				accommodationMap.put(name, value);
			}

			// 이미지 파일 처리 (기존 이미지 삭제 후 새로 업로드)
			List<MultipartFile> mFiles = multipartRequest.getFiles("accommodation_photo[]");
			List<String> fileList = new ArrayList<>();

			boolean hasValidFile = false;
			if (mFiles != null && !mFiles.isEmpty()) {
				for (MultipartFile file : mFiles) {
					if (file != null && !file.isEmpty()) {
						hasValidFile = true;
						break;
					}
				}
			}

			if (hasValidFile) {
				File destDir = new File(DEST_DIR + accommodationMap.get("accommodation_id"));
				destDir.mkdirs();
				FileUtils.cleanDirectory(destDir); // 기존 이미지 폴더 비우기 지우지말기

				for (MultipartFile mFile : mFiles) {
					if (mFile != null && !mFile.isEmpty()) {
						String originalFilename = mFile.getOriginalFilename();
						File targetFile = new File(destDir, originalFilename);
						mFile.transferTo(targetFile);
						fileList.add(originalFilename);
					}
				}
				accommodationMap.put("accommodation_photo", String.join(",", fileList));
			} else {
				// 새로운 이미지가 업로드되지 않은 경우, 기존 이미지 정보 유지
				AccommodationDTO existingAccommodation = service.findAccommodationId((String) accommodationMap.get("accommodation_id"));
				accommodationMap.put("accommodation_photo", existingAccommodation.getAccommodation_photo());
			}

			// 서비스 호출하여 업데이트
			service.updateAccommodation(accommodationMap);

			String accommodation_id = (String) accommodationMap.get("accommodation_id");
			String accommodation_name = (String) accommodationMap.get("accommodation_name");
			String message = "<script>alert('숙소 정보를 수정했습니다.'); location.href='" 
					+ request.getContextPath() 
					+ "/accommodation/accommodationPage.do?accommodation_id=" 
					+ accommodation_id 
					+ "&accommodation_name=" 
					+ accommodation_name 
					+ "';</script>";
			resEntity = new ResponseEntity<>(message, headers, HttpStatus.CREATED);

		} catch (Exception e) {
			String accommodation_id = multipartRequest.getParameter("accommodation_id");
			String message = "<script>alert('오류가 발생했습니다. 다시 시도해주세요.'); location.href='" + request.getContextPath() + "/accommodation/accommodationPage.do?accommodation_id=" + accommodation_id +"?accommodation_name=" + accommodation_id + "';</script>";
			resEntity = new ResponseEntity<>(message, headers, HttpStatus.CREATED);
			e.printStackTrace();
		}
		return resEntity;
	}

	@RequestMapping("/checkName.do")
	public void checkName(HttpServletRequest request,HttpServletResponse response) {
		String accommodation_name = request.getParameter("accommodation_name");
		boolean exists = service.checkName(accommodation_name);

		response.setContentType("application/json");
		try (PrintWriter out = response.getWriter()) {
			// 중복 여부를 JSON으로 반환
			out.print("{\"exists\": " + exists + "}");
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	@RequestMapping(value = "/searchAddress", method = RequestMethod.GET)
	public ModelAndView searchAddress(@RequestParam("keyword") String keyword) {
		// 'ㆍ'로 키워드 분리
		List<String> regions = Arrays.asList(keyword.split("ㆍ"));

		// 검색 로직 처리
		List<AccommodationDTO> searchResults = service.searchAddress(regions);

		ModelAndView mav = new ModelAndView("/accommodation/searchResults");
		mav.addObject("searchResults", searchResults);
		return mav;
	}
	
	@RequestMapping("/startMain.do")
	public ModelAndView startMain (HttpServletResponse response, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("startMain");
		return mav;
	}


}