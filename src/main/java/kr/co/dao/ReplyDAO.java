package kr.co.dao;

import java.util.List;

import kr.co.vo.ReplyVO;

public interface ReplyDAO {
	// 댓글 목록
	public List<ReplyVO> readReply(int bno) throws Exception;
	// 댓글 작성
	public void writeReply(ReplyVO replyVO) throws Exception;
	// 댓글 수정
	public void updateReply(ReplyVO replyVO) throws Exception;
	// 댓글 삭제
	public void deleteReply(int rno) throws Exception;
	// 댓글 상세 보기
	public ReplyVO selectReply(int rno) throws Exception;
}
