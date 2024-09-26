/*
 * package com.teamproject.myteam01.controller;
 * 
 * import org.springframework.stereotype.Controller; import
 * org.springframework.ui.Model; import
 * org.springframework.web.bind.annotation.GetMapping; import
 * org.springframework.web.bind.annotation.PostMapping; import
 * org.springframework.web.bind.annotation.RequestMapping; import
 * org.springframework.web.bind.annotation.RequestParam;
 * 
 * import com.teamproject.myteam01.domain.CsVO; import
 * com.teamproject.myteam01.service.CsService;
 * 
 * import io.swagger.v3.oas.annotations.tags.Tag; import
 * lombok.RequiredArgsConstructor;
 * 
 * @Controller
 * 
 * @RequiredArgsConstructor
 * 
 * @RequestMapping("/cs")
 * 
 * @Tag(name = "CsController", description = "Customer Service") public class
 * CsController {
 * 
 * private final CsService csService;
 * 
 * 
 * @GetMapping("/Center") public String csList(Model model) {
 * model.addAttribute("CsList", csService.csList()); // FAQ 목록
 * 
 * model.addAttribute("feedbackList", csService.csFBList()); // 고객의 소리 목록
 * 
 * model.addAttribute("inquiryList", csService.csInList()); // 1:1 문의 내역 목록
 * 
 * return "csCenter"; }
 * 
 * 
 * @GetMapping("/register") public String showFaqRegisterForm() { return
 * "CsRegister"; }
 * 
 * 
 * 
 * @PostMapping("/registerProc") public String regiFAQ(@RequestParam(value =
 * "type") String type, CsVO csvo) { if ("faq".equals(type)) {
 * csService.regiFAQ(csvo); } else if ("feedback".equals(type)) {
 * csService.regiFB(csvo); // 고객의 소리 등록 메서드 추가 } else if
 * ("inquiry".equals(type)) { csService.regiIn(csvo); // 1:1 문의 등록 메서드 추가 }
 * return "redirect:/cs/Center"; }
 * 
 * 
 * 
 * 
 * @GetMapping("/edit") public String showCsEditForm(@RequestParam(value =
 * "type") String type, @RequestParam(value = "id") Long id, Model model) { CsVO
 * cs = null;
 * 
 * if ("faq".equals(type)) { cs = csService.getFAQ(id); // FAQ 데이터 가져오기 } else
 * if ("feedback".equals(type)) { cs = csService.getFB(id); // Feedback 데이터 가져오기
 * } else if ("inquiry".equals(type)) { cs = csService.getIn(id); // Inquiry 데이터
 * 가져오기 }
 * 
 * model.addAttribute("cs", cs); model.addAttribute("type", type); return
 * "CsEdit"; }
 * 
 * 
 * 
 * 
 * @PostMapping("/editProc") public String editProc(@RequestParam("type") String
 * type, CsVO cs) { // 각 필드 값 출력 (디버깅용) System.out.println("FAQNO: " +
 * cs.getFaqno()); System.out.println("INQNO: " + cs.getIno());
 * System.out.println("FBNO: " + cs.getFbno()); System.out.println("Title: " +
 * cs.getFaqtitle() + ", " + cs.getItitle() + ", " + cs.getFbtitle());
 * System.out.println("Content: " + cs.getFaqcontent() + ", " + cs.getIcontent()
 * + ", " + cs.getFbcontent()); System.out.println("Response: " +
 * cs.getIresponse());
 * 
 * boolean success = false;
 * 
 * if ("faq".equals(type)) { success = csService.modifyFAQ(cs); } else if
 * ("feedback".equals(type)) { success = csService.modifyFB(cs); } else if
 * ("inquiry".equals(type)) { success = csService.modifyIn(cs); }
 * 
 * if (success) { return "redirect:/cs/Center"; // 수정 성공 시 } else { // 수정 실패 시
 * 타입에 따라 리다이렉트 if ("faq".equals(type)) { return "redirect:/cs/edit?faqno=" +
 * cs.getFaqno(); } else if ("feedback".equals(type)) { return
 * "redirect:/cs/edit?fbno=" + cs.getFbno(); } else if ("inquiry".equals(type))
 * { return "redirect:/cs/edit?ino=" + cs.getIno(); } } return
 * "redirect:/cs/Center"; // 기본 리다이렉트 (예외 처리) }
 * 
 * 
 * 
 * @PostMapping("/deleteFAQ") public String deleteFAQ(@RequestParam("faqno")
 * Long faqno) { boolean isDeleted = csService.removeFAQ(faqno); if (isDeleted)
 * { return "redirect:/cs/Center"; // 삭제 후 목록 페이지로 리다이렉트 } else { // 삭제 실패 시 처리할
 * 로직 (예: 오류 페이지로 리다이렉트) return "redirect:/cs/Center?error=true"; } }
 * 
 * 
 * 
 * 
 * }
 */

package com.teamproject.myteam01.controller;

import java.util.List;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.teamproject.myteam01.domain.CsVO;
import com.teamproject.myteam01.service.CsService;

import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/cs")
@Tag(name = "CsController", description = "Customer Service")
public class CsController {

    private final CsService csService;

    @GetMapping("/Center")
    public String csList(Model model) {

		System.out.println("________________________"+csService.getNoticeList());
    	model.addAttribute("notice",csService.getNoticeList()); //공지사항 목록
    	model.addAttribute("event", csService.getEventList());
        model.addAttribute("CsList", csService.csList()); // FAQ 목록
        model.addAttribute("feedbackList", csService.csFBList()); // 고객의 소리 목록
        model.addAttribute("inquiryList", csService.csInList()); // 1:1 문의 내역 목록
        return "csCenter";
    }

    @GetMapping("/register")
    public String showFaqRegisterForm() {
        return "CsRegister";
    }

    // 등록 처리
    @PostMapping("/registerProc")

    public String regiFAQ(@RequestParam(value = "type") String type, CsVO csvo, @AuthenticationPrincipal UserDetails userDetails, RedirectAttributes redirectAttributes) {
        String userId = userDetails.getUsername(); // 로그인된 사용자의 ID 가져오기
        csvo.setUserid(userId); // 문의나 건의사항에 USERID 추가


        if ("faq".equals(type)) {
            csService.regiFAQ(csvo);
        } else if ("feedback".equals(type)) {
            csService.regiFB(csvo); // 고객의 소리 등록
        } else if ("inquiry".equals(type)) {
            csService.regiIn(csvo); // 1:1 문의 등록 메서드
        } else if ("notice".equals(type)) {
        	csService.regNotice(csvo);
        } else if ("event".equals(type)) {
        	csService.regEvent(csvo);
        }
        
        redirectAttributes.addFlashAttribute("message", "등록이 성공적으로 완료되었습니다.");
        return "redirect:/cs/Center";
    }

    // 수정 처리
    @GetMapping("/edit")
    public String showCsEditForm(@RequestParam(value = "type") String type, 
    							 @RequestParam(value = "faqno", required = false) Long faqno, 
                                 @RequestParam(value = "fbno", required = false) Long fbno, 
                                 @RequestParam(value = "ino", required = false) Long ino,
                                 @RequestParam(value = "notice_num", required = false) Long notice_num,
                                 @RequestParam(value = "event_num", required = false) Long event_num, Model model) {
        CsVO cs = new CsVO();

        if ("faq".equals(type) && faqno != null) {
            cs = csService.getFAQ(faqno);
        } else if ("feedback".equals(type) && fbno != null) {
            cs = csService.getFB(fbno);
        } else if ("inquiry".equals(type) && ino != null) {
            cs = csService.getIn(ino);
        }else if ("notice".equals(type) && notice_num != null) {
            cs = csService.getNoticeDetail(notice_num);
            System.out.println("------------------------------공지사항 데이터: " + cs);
        } else if ("event".equals(type) && event_num != null) {
            cs = csService.getEventDetail(event_num);
            System.out.println("------------------------------이벤트 데이터: " + cs);
        }

        model.addAttribute("cs", cs);
        model.addAttribute("type", type);
        return "CsEdit";
    }

    @PostMapping("/editProc")
    public String editProc(@RequestParam("type") String type, CsVO cs) {
        boolean success = false;
        
        if ("faq".equals(type)) {
            success = csService.modifyFAQ(cs);
        } else if ("feedback".equals(type)) {
            success = csService.modifyFB(cs);
        } else if ("inquiry".equals(type)) {
            success = csService.modifyIn(cs);
        } else if ("notice".equals(type)) {
            success = csService.modifyNT(cs);
        } else if ("event".equals(type)) {
            success = csService.modifyAE(cs);
        }

        if (success) {
            return "redirect:/cs/Center"; // 수정 성공 시
        } else {
            // 수정 실패 시 타입에 따라 리다이렉트
            if ("faq".equals(type)) {
                return "redirect:/cs/edit?faqno=" + cs.getFaqno();
            } else if ("feedback".equals(type)) {
                return "redirect:/cs/edit?fbno=" + cs.getFbno();
            } else if ("inquiry".equals(type)) {
                return "redirect:/cs/edit?ino=" + cs.getIno();
             } else if ("notice".equals(type)) {
                return "redirect:/cs/edit?notice_num=" + cs.getNotice_num();
            } else if ("event".equals(type)) {
                return "redirect:/cs/edit?event_num=" + cs.getEvent_num();
            }
        }
        return "redirect:/cs/Center"; // 기본 리다이렉트 (예외 처리)
    }




    @PostMapping("/deleteProc")
    public String deleteProc(@RequestParam("type") String type, @RequestParam("no") Long no) {
        if (type.equals("faq")) {
            csService.removeFAQ(no);
        } else if (type.equals("feedback")) {
            csService.removeFB(no);
        } else if (type.equals("inquiry")) {
            csService.removeIn(no);
        } else if (type.equals("notice")) {
            csService.removeNT(no);
        } else if (type.equals("event")) {
            csService.removeAE(no);
        }
        
        
        
        return "redirect:/cs/Center"; // 삭제 후 리다이렉트
    }

    
    /////////////////////////////////
    
    @PostMapping("/register/notice")
    public void regiNotice (@RequestParam("notice_title") String nctitle,
    						@RequestParam("notice_content") String nccontent) {
    	CsVO cs = new CsVO();
    	cs.setNotice_title(nctitle);
    	cs.setNotice_content(nccontent);
    	csService.regNotice(cs);
    }
    
    @GetMapping("/get/notice/detail")
    public List<CsVO> getNoiceList(){
    	return null;
    }
    
    @GetMapping("/get/notice/list")
    public CsVO geNoticeDetail(@RequestParam("nno") Long nno) {
        return csService.getNoticeDetail(nno);
    }
    
    
}

