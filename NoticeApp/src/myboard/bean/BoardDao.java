package myboard.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import oracle.jdbc.proxy.annotation.Pre;

public class BoardDao {
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	
	public BoardDao(){
		try{
			Context ctx = new InitialContext();
			ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracleDB");
		}
		catch(Exception err){
			System.out.println("DB연결 실패 : " + err);
		}
	}
	
	public void freeConnection(){
		if(rs != null){try{rs.close();}catch(Exception err){}}
		if(pstmt != null){try{pstmt.close();}catch(Exception err){}}
		if(con != null){try{con.close();}catch(Exception err){}}
	}
	
	// 전체글 조회(List.jsp)
	public ArrayList getBoardList(String keyField, String keyWord){
		ArrayList list = new ArrayList();
		String sql = null;
		
		if(keyWord == null || keyWord.isEmpty()){
			sql = "select * from tblBoard order by b_pos";
		}
		else{
			sql = "select * from tblBoard where " + keyField
				+ " like '%" + keyWord + "%' order by b_pos";
		}
		
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				BoardDto dto = new BoardDto();
				
				dto.setB_content(rs.getString("b_content"));
				dto.setB_count(rs.getInt("b_count"));
				dto.setB_depth(rs.getInt("b_depth"));
				dto.setB_email(rs.getString("b_email"));
				dto.setB_homepage(rs.getString("b_homepage"));
				dto.setB_ip(rs.getString("b_ip"));
				dto.setB_name(rs.getString("b_name"));
				dto.setB_num(rs.getInt("b_num"));
				dto.setB_pass(rs.getString("b_pass"));
				dto.setB_pos(rs.getInt("b_pos"));
				dto.setB_regdate(rs.getString("b_regdate"));
				dto.setB_subject(rs.getString("b_subject"));
				
				list.add(dto);
			}
		}
		catch(Exception err){
			System.out.println("getBoardList() : " + err);
		}
		finally{
			freeConnection();
		}
		
		return list;
	}
	
	private void updatePos(Connection con){
		try{
			String sql = "update tblBoard set b_pos=b_pos+1";
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();
		}
		catch(Exception err){
			System.out.println("updatePos : " + err);
		}
	}
	
	// 글쓰기(Post.jsp, Postproc.jsp)
	public void insertBoard(BoardDto dto){
		String sql = "insert into tblboard(b_num, b_name, "
			+ "b_email, b_homepage, b_subject, b_content, "
			+ "b_regdate, b_pass, b_count, b_ip, b_pos, "
			+ "b_depth) values(seq_num.nextVal, ?,?,?,?,?, "
			+ "sysdate, ?, 0, ?, 0, 0)";
		
		try{
			con = ds.getConnection();
			
			updatePos(con);
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getB_name());
			pstmt.setString(2, dto.getB_email());
			pstmt.setString(3, dto.getB_homepage());
			pstmt.setString(4, dto.getB_subject());
			pstmt.setString(5, dto.getB_content());
			pstmt.setString(6, dto.getB_pass());
			pstmt.setString(7, dto.getB_ip());
			
			pstmt.executeUpdate();
		}
		catch(Exception err){
			System.out.println("insertBoard : " + err);
		}
		finally{
			freeConnection();
		}
	}
	
	// 글읽기(Read.jsp, Update.jsp)
	public BoardDto getBoard(int num, String page){
		String sql = null;
		BoardDto dto = new BoardDto();
		
		try{
			con = ds.getConnection();
			
			if(page.equals("read")){
				sql = "update tblBoard set b_count=b_count+1 where b_num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
			}
			
			sql = "select * from tblBoard where b_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				dto.setB_content(rs.getString("b_content"));
				dto.setB_count(rs.getInt("b_count"));
				dto.setB_depth(rs.getInt("b_depth"));
				dto.setB_email(rs.getString("b_email"));
				dto.setB_homepage(rs.getString("b_homepage"));
				dto.setB_ip(rs.getString("b_ip"));
				dto.setB_name(rs.getString("b_name"));
				dto.setB_num(rs.getInt("b_num"));
				dto.setB_pass(rs.getString("b_pass"));
				dto.setB_pos(rs.getInt("b_pos"));
				dto.setB_regdate(rs.getString("b_regdate"));
				dto.setB_subject(rs.getString("b_subject"));
			}
		}
		catch(Exception err){
			System.out.println("getBoard() : " + err);
		}
		finally{
			freeConnection();
		}
		
		return dto;
	}
	
	// 글 수정(UpdateProc.jsp)
	public void updateBoard(BoardDto dto){
		String sql = "update tblboard set b_name=?, "
				+ "b_email=?, b_subject=?, b_content=? where b_num=?";
			
			try{
				con = ds.getConnection();
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, dto.getB_name());
				pstmt.setString(2, dto.getB_email());
				pstmt.setString(3, dto.getB_subject());
				pstmt.setString(4, dto.getB_content());
				pstmt.setInt(5, dto.getB_num());
				
				pstmt.executeUpdate();
			}
			catch(Exception err){
				System.out.println("updateBoard : " + err);
			}
			finally{
				freeConnection();
			}
	}
	
	// 글 삭제(Delete.jsp)
	public void deleteBoard(int num){
		String sql = "delete from tblboard where b_num=?";
			
		try{
			con = ds.getConnection();
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		}
		catch(Exception err){
			System.out.println("deleteBoard : " + err);
		}
		finally{
			freeConnection();
		}
	}
	
	// 답변 달기전 부모글의 pos보다 큰 pos를 1 증가 시키기 위한 메서드
	public void replyUpdatePos(BoardDto dto){
		try{
			String sql = "update tblboard set b_pos=b_pos+1 where b_pos>?";
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dto.getB_pos());
			pstmt.executeUpdate();
		}
		catch(Exception err){
			System.out.println("replyUpdatePos : " + err);
		}
		finally{
			freeConnection();
		}
	}
	
	// 답변 달기
	public void replyBoard(BoardDto dto){
		String sql = "insert into tblboard(b_num, b_name, "
				+ "b_email, b_homepage, b_subject, b_content, "
				+ "b_regdate, b_pass, b_count, b_ip, b_pos, "
				+ "b_depth) values(seq_num.nextVal, ?,?,?,?,?, "
				+ "sysdate, ?, 0, ?, ?, ?)";
			
		try{
			con = ds.getConnection();
			
			updatePos(con);
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getB_name());
			pstmt.setString(2, dto.getB_email());
			pstmt.setString(3, dto.getB_homepage());
			pstmt.setString(4, dto.getB_subject());
			pstmt.setString(5, dto.getB_content());
			pstmt.setString(6, dto.getB_pass());
			pstmt.setString(7, dto.getB_ip());
			pstmt.setInt(8, dto.getB_pos()+1);
			pstmt.setInt(9, dto.getB_depth()+1);
			
			pstmt.executeUpdate();
		}
		catch(Exception err){
			System.out.println("replyBoard : " + err);
		}
		finally{
			freeConnection();
		}
	}
	
	// 들여쓰기
	public String useDepth(int depth){
		String result = "";
		for(int i=0; i<depth*3; i++){
			result += "&nbsp;";
		}
		return result;
	}
}