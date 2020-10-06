package co.salpa.bookery.model;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import co.salpa.bookery.model.entity.BookVo;
import co.salpa.bookery.model.entity.ClubVo;
import co.salpa.bookery.model.entity.RecommendVo;

public interface ClubDao {

	List<ClubVo> selectNotice() throws DataAccessException;	//모든 공지사항 불러오기
	
	List<ClubVo> selectOneToOne() throws DataAccessException;	//1:1문 글 불러오기

	ClubVo selectOneNotice(int id) throws DataAccessException;	//특정 공지사항 불러오기
	
	List<ClubVo> selectNewsNotice() throws DataAccessException;	//책거리 뉴스 메인 게시판에서 공지 3개만 불러오기

	List<ClubVo> selectContentForNews() throws DataAccessException;	//책거리 뉴스 메인 실시간 게시글

	List<ClubVo> popularContents() throws DataAccessException;	//북클럽 인기글

	List<ClubVo> selectBookClubAll() throws DataAccessException;

	List<ClubVo> selectAboutBook(ClubVo club) throws DataAccessException; // 북클럽 특정책 리스트불러오기

	void insertBookClub(BookVo book) throws DataAccessException;

	void insertNotice(ClubVo club) throws DataAccessException;	//공지사항 글 작성
	
	void updateNotice(ClubVo club) throws DataAccessException; // 공지사항 수정

	void updateRef(int id) throws DataAccessException;	//1:1문의글에 답글달렸을시 해당 문의글의 ref 업데이트
	

	void deleteClubData(int id) throws DataAccessException;

	ClubVo selectOneClub(int id) throws DataAccessException;// 북클럽 특정책 리스트에서 글 보기

	List<ClubVo> selectMore(ClubVo club) throws DataAccessException;// 북클럽 특정책 리스트 더 불러오기(더보기버튼누름)

	void insertOneClub(ClubVo club) throws DataAccessException;// 북클럽 특정 책에 글쓰기

	int countOfPosts(int book_bid) throws DataAccessException; // 특정책의 게시글 수

	void insertReplyClub(ClubVo club) throws DataAccessException; // 게시글 댓글 작성

	List<ClubVo> selectReplyById(int id) throws DataAccessException; // 게시글 댓글 목록

	void updateClubPost(ClubVo club) throws DataAccessException; // 게시글 수정하기

	void updateReply(ClubVo club) throws DataAccessException; // 댓글 수정

	void updateRecommendUp(int id) throws DataAccessException; // 댓글 추천+1

	void insertRecommendChk(RecommendVo recommendVo) throws DataAccessException; // 댓글 추천 기록

	List<Integer> selectAllRecommend(int user_id) throws DataAccessException; // 로그인한 유저의 추천기록 리스트

	void updateRecommendDown(int id) throws DataAccessException; // 댓글 추천-1

	void deleteRecommendChk(RecommendVo recommendVo) throws DataAccessException; // 댓글 추천 기록 취소

}
