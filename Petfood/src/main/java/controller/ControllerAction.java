package controller;

import java.io.*;//FileInputStream
import java.util.*;//Map,Properties
import javax.servlet.*;
import javax.servlet.http.*;
//추가->다른 패키지의 클래스나 인터페이스를 참조
import action.CommandAction;

public class ControllerAction extends HttpServlet {

	// 명령어와 명령어 처리클래스를 쌍으로 저장
	private Map commandMap = new HashMap();

	// 서블릿을 실행시 서블릿의 초기화 작업->생성자
	public void init(ServletConfig config) throws ServletException {

		// 경로에 맞는 CommandPro.properties파일을 불러옴
		String props = ControllerAction.class.getResource("").getPath() 
				+ config.getInitParameter("propertyConfig");
		
		System.out.println("불러온경로=" + props);

		Properties pr = new Properties();
		FileInputStream f = null;

		try {
			f = new FileInputStream(props);

			pr.load(f);

		} catch (IOException e) {
			throw new ServletException(e);
		} finally {
			if (f != null)
				try {
					f.close();
				} catch (IOException ex) {
				}
		}

		Iterator keyiter = pr.keySet().iterator();

		while (keyiter.hasNext()) {
			String command = (String) keyiter.next();
			System.out.println("command=" + command);
			
			String className = pr.getProperty(command);
			System.out.println("className=" + className);

			try {
				Class commandClass = Class.forName(className);
				System.out.println("commandClass=" + commandClass);
				Object commandInstance = commandClass.newInstance();
				System.out.println("commandInstance=" + commandInstance);

				commandMap.put(command, commandInstance);
				System.out.println("commandMap=" + commandMap);

			} catch (ClassNotFoundException e) {
				throw new ServletException(e);
			} catch (InstantiationException e) {
				throw new ServletException(e);
			} catch (IllegalAccessException e) {
				throw new ServletException(e);
			}
		} // while
	}

	public void doGet(
			HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		requestPro(request, response);
	}

	protected void doPost(
			HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		requestPro(request, response);
	}

	private void requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String view = null;
		CommandAction com = null;

		try {
			String command = request.getRequestURI();
			System.out.println("command => " + command);

			if (command.indexOf(request.getContextPath()) == 0) {
				command = command.substring(request.getContextPath().length());
				System.out.println("command => " + command);
			}

			com = (CommandAction) commandMap.get(command);
			System.out.println("com => " + com);

			view = com.requestPro(request, response);
			System.out.println("view => " + view);

		} catch (Throwable e) {
			throw new ServletException(e);
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher(view);
		dispatcher.forward(request, response);
	}
}