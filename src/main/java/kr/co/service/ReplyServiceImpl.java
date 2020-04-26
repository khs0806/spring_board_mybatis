package kr.co.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.dao.BoardDAO;
import kr.co.dao.ReplyDAO;
import kr.co.vo.BoardVO;
import kr.co.vo.Criteria;
import kr.co.vo.ReplyVO;
import kr.co.vo.SearchCriteria;

@Service
public class ReplyServiceImpl implements ReplyService {
	
	@Inject 
	private ReplyDAO replyDAO;
	// 댓글 조회
	@Override
	public List<ReplyVO> readReply(int bno) throws Exception {
		return replyDAO.readReply(bno);
	}
	// 댓글 작성
	@Override
	public void writeReply(ReplyVO replyVO) throws Exception {
		replyDAO.writeReply(replyVO);
	}
}
