
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet({ "/joinForm", "/idChek", "/memberJoin" })
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doProcess(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String uri = request.getRequestURI();
		String conpath = request.getContextPath();
		String url = uri.substring(conpath.length());
		String path = null;
		ShoppingDao sDao = new ShoppingDao(request);

		switch (url) {
		case "/joinForm":
			path = sDao.joinForm();
			break;
		case "/idChek":
			String result = sDao.idChek(request);
			
			/*모듈화*/
			response.setContentType("application/json");
			PrintWriter out = response.getWriter();
			out.print(result);
			out.flush();
			out.close();
			out = null;
			break;
		case "/memberJoin":
			path = sDao.memberJoin();
			break;
		default:
			break;
		}

		if (path != null) {
			RequestDispatcher dis = request.getRequestDispatcher(path);
			dis.forward(request, response);
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doProcess(request, response);
	}

}
