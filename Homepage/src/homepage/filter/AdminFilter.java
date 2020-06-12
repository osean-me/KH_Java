package homepage.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import homepage.beans.dto.MemberDTO;

@WebFilter(urlPatterns = "/admin/*")
public class AdminFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;

		MemberDTO mdto = (MemberDTO) req.getSession().getAttribute("userinfo");

		if (mdto == null) {

			resp.sendRedirect(req.getContextPath() + "/user/login.jsp");

		} else if (!mdto.getAccess_auth().equals("운영자")) {

			resp.sendRedirect(req.getContextPath() + "?error");

		} else {

			chain.doFilter(request, response);

		}

	}
}