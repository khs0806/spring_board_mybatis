package kr.co.controller;



import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.service.MemberService;
import kr.co.vo.MemberVO;

@Controller
@RequestMapping("/member/*")
public class MemberController {

	@Inject
	MemberService memberService;
	
	BCryptPasswordEncoder pwdEncoder = new BCryptPasswordEncoder();
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	// 회원가입 GET 요청
	@RequestMapping(value="/register", method=RequestMethod.GET)
	public void getRegister() throws Exception{
		logger.info("get register");
	}
	// 회원가입 POST 요청
	@RequestMapping(value="/register", method=RequestMethod.POST)
	public String postRegister(MemberVO vo)throws Exception{
		logger.info("post register");
		int result = memberService.idChk(vo);
		
		try {
			if (result == 1) {
				return "member/register";
			} else {
				String input = vo.getUserPw();
				String pwd = pwdEncoder.encode(input);
				vo.setUserPw(pwd);
				memberService.register(vo);
			}
			
		} catch (Exception e) {
			throw new RuntimeException();
		}
		return "redirect:/";
	}
	// 로그인
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String login(MemberVO vo, HttpServletRequest req, RedirectAttributes rttr) throws Exception{
		logger.info("login");
		System.out.println(vo.toString());
		HttpSession session = req.getSession();
		MemberVO login = memberService.login(vo);
		
		if (login == null) {
			session.setAttribute("member", null);
			rttr.addFlashAttribute("msg", false);
			return "redirect:/";
		}
		boolean pwdMatch = pwdEncoder.matches(vo.getUserPw(), login.getUserPw());
		if (pwdMatch == true) {
			session.setAttribute("member", login);
			return "redirect:/board/list";
		} else {
			session.setAttribute("member", null);
			rttr.addFlashAttribute("msg", false);
			return "redirect:/";
		}
	}
	// 로그아웃
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String logout(HttpSession session) throws Exception{
		session.invalidate();
		return "redirect:/";
	}
	// 회원정보 수정뷰
	@RequestMapping(value="/memberUpdateView", method=RequestMethod.GET)
	public String memberUpdateView() throws Exception{
		return "member/memberUpdateView";
	}
	// 회원정보 수정
	@RequestMapping(value="/memberUpdate", method=RequestMethod.POST)
	public String memberUpdate(MemberVO vo, HttpSession session) throws Exception{
		String input = vo.getUserPw();
		String pwd = pwdEncoder.encode(input);
		vo.setUserPw(pwd);
		System.out.println(vo.toString());
		memberService.memberUpdate(vo);
		session.invalidate();
		return "redirect:/";
	}
	// 회원탈퇴 GET
	@RequestMapping(value="/memberDeleteView", method=RequestMethod.GET)
	public String memberDeleteView() throws Exception {
		return "member/memberDeleteView";
	}
	// 회원탈퇴 POST
	@RequestMapping(value="/memberDelete", method=RequestMethod.POST)
	public String memberDelete(MemberVO vo, HttpSession session, RedirectAttributes rttr) throws Exception{
//		// session에 있는 member를 가져온다
//		MemberVO member = (MemberVO) session.getAttribute("member");
//		// session에 있는 비밀번호
//		String sessionPass = member.getUserPw();
//		// 유저가 입력한 비밀번호
//		String voPass = vo.getUserPw();
//		
//		if (!sessionPass.equals(voPass)) {
//			rttr.addFlashAttribute("msg", false);
//			return "redirect:/member/memberDeleteView";
//		} else {
//			memberService.memberDelete(vo);
//			session.invalidate();
//			return "redirect:/";
//		}
		
		memberService.memberDelete(vo);
		session.invalidate();
		return "redirect:/";
	}
	// 패스워드 체크
	@ResponseBody
	@RequestMapping(value="/passChk", method=RequestMethod.POST)
	public boolean passChk(MemberVO vo) throws Exception{
		MemberVO login = memberService.login(vo);
		boolean pwChk = pwdEncoder.matches(vo.getUserPw(), login.getUserPw());
		return pwChk;
	}
	// 아이디 중복체크
	@ResponseBody
	@RequestMapping(value="/idChk", method=RequestMethod.POST)
	public int idChk(MemberVO vo) throws Exception {
		int result = memberService.idChk(vo);
		return result;
	}
}
