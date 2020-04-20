package kr.co.controller;


import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.service.BoardService;
import kr.co.vo.BoardVO;
import kr.co.vo.Criteria;
import kr.co.vo.PageMaker;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	private PageMaker pageMaker;
	
	@Autowired
	private BoardService service;
	
	// 게시판 글 작성 화면
	@RequestMapping(value = "/board/writeView", method = RequestMethod.GET)
	public void writeView() throws Exception{
		
	}
	
	// 게시판 글 작성
	@RequestMapping(value = "/board/write", method = RequestMethod.POST)
	public String write(BoardVO boardVO) throws Exception{
		logger.info("write");
		service.write(boardVO);
		
		return "redirect:/board/list";
	}
	
	// 게시물 목록
	@RequestMapping(value ="/list", method = RequestMethod.GET)
	public String listView(Model model, Criteria cri) throws Exception{
		logger.info("list");
		List<BoardVO> vo = service.list(cri);
		model.addAttribute("list", vo);
		
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.listCount());
		model.addAttribute("pageMaker", pageMaker);
		
		return "board/list";
	}
	
	// 게시물 조회
	@RequestMapping(value="/readView", method = RequestMethod.GET)
	public String read(BoardVO boardVO, Model model) throws Exception{
		logger.info("read");
		System.out.println(boardVO.getContent());
		int bno = boardVO.getBno();
		BoardVO vo = service.read(bno);
		model.addAttribute("read", vo);
		return "board/readView";
	}
	
	// 게시물 수정 뷰
	@RequestMapping(value="/updateView")
	public String updateView(BoardVO boardVO, Model model) throws Exception{
		logger.info("updateView");
		BoardVO vo = service.read(boardVO.getBno());
		model.addAttribute("update", vo);
	
		return "board/updateView";
	}
	
	// 게시물 수정
	@RequestMapping(value="/update", method = RequestMethod.POST)
	public String update(BoardVO boardVO) throws Exception{
		logger.info("update");
		service.update(boardVO);
		return "redirect:/board/list";
	}
	
	// 게시판 삭제
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public String delete(BoardVO boardVO) throws Exception{
		logger.info("delete");
		int bno = boardVO.getBno();
		service.delete(bno);
		return "redirect:/board/list";
	}
	
}
