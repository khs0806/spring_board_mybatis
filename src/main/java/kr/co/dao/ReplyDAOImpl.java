package kr.co.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.vo.BoardVO;
import kr.co.vo.Criteria;
import kr.co.vo.ReplyVO;
import kr.co.vo.SearchCriteria;

@Repository
public class ReplyDAOImpl implements ReplyDAO {

	@Inject SqlSession session;
	
	// 댓글조회
	@Override
	public List<ReplyVO> readReply(int bno) throws Exception {
		return session.selectList("replyMapper.readReply", bno);
	}
	// 댓글 작성
	@Override
	public void writeReply(ReplyVO replyVO) throws Exception {
		session.insert("replyMapper.writeReply", replyVO);
	}

	

}
