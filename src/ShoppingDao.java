import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

public class ShoppingDao {
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	HttpServletRequest request;

	public ShoppingDao(HttpServletRequest request) {
		this.request = request;
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			con = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");
		} catch (Exception e) {
			System.out.println("연결 실패");
			e.printStackTrace();
		}
	}

	public String joinForm() {
		// member테이블에서 MAX를 이용해 custno의 가장 큰 값을 가져온다.
		// 오늘 날짜를 조회해온다.
		String sql = "SELECT MAX(CUSTNO),SYSDATE FROM MEMBER";
		int custno = 0;
		String date = null;
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				// 가져온 custno값을 넣어준다.
				custno = rs.getInt("MAX(CUSTNO)");
				// 가져온 날짜를 넣어준다.
				date = rs.getString("SYSDATE");
			}
		} catch (SQLException e) {
			System.out.println("joinForm() 에러");
			e.printStackTrace();
		}
		// 가져온 custno값에 +1해준다.
		request.setAttribute("custno", custno + 1);
		// 가져온 날짜값의 첫번째 부터 10번째까지 잘라준다.
		request.setAttribute("date", date.substring(0, 10));
		// 해당 페이지에 파라미터 값 리턴
		return "index.jsp?page=joinForm";
	}

	public String idChek(HttpServletRequest id) {
		int result = 0;
		String userid = id.getParameter("id");
		String sql = "SELECT COUNT(*) FROM MEMBER WHERE ID = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt("COUNT(*)");
			}
		} catch (SQLException e) {
			System.out.println("idChek() 에러");
			e.printStackTrace();
		}
		request.setAttribute("result", result);
		return "{\"status\":\"idOk\", \"count\":" + result + "}";
	}

	public String memberJoin() {
		memberBean mb = new memberBean();
		StringBuilder sb = new StringBuilder();
		// joinForm에서 get한 값을 Bean에 set해준다.
		mb.setCustno(Integer.parseInt(request.getParameter("custno")));
		mb.setJoindate(request.getParameter("joindate"));
		mb.setId(request.getParameter("id"));
		mb.setPw(request.getParameter("pw"));
		mb.setName(request.getParameter("name"));
		mb.setAddr(request.getParameter("addr"));
		mb.setBirth(request.getParameter("birth"));
		mb.setEmail(request.getParameter("email"));
		System.out.println(mb.getCustno() + mb.getEmail());

		String sql = "INSERT INTO MEMBER VALUES(?,?,?,?,?,?,?,?)";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, mb.getCustno());
			pstmt.setString(2, mb.getId());
			pstmt.setString(3, mb.getPw());
			pstmt.setString(4, mb.getName());
			pstmt.setString(5, mb.getAddr());
			pstmt.setString(6, mb.getBirth());
			pstmt.setString(7, mb.getEmail());
			pstmt.setString(8, mb.getJoindate());
			int result = pstmt.executeUpdate();
			if (result != 0) {
				request.setAttribute("success", sb.append("<script> alert('회원등록이 완료되었습니다.') <script>"));
				return "index.jsp";
			}
		} catch (SQLException e) {
			System.out.println("memberJoin() 에러");
			e.printStackTrace();
		}
		request.setAttribute("false", sb.append("<script> alert('회원등록에 실패했습니다.') <script>"));
		return "index.jsp?page=joinForm";
	}

}
