<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%@ include file="../menu/nav.jsp"%>
	<%@ include file="../menu/footer.jsp"%>
	<link rel="stylesheet" type="text/css" href="/css/vroomPolicy.css"> 
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Vroom Policy</title>


	    <!-- Admin 로그인 시 스타일을 변경 -->
    <sec:authorize access="hasRole('ADMIN')">
    <style>
        /* 관리자일 때 핑크색 스타일 적용 */
        .menu {
            background-color: #003366; /* 핑크로 변경 */
        }
        .menu a {
            color: #003366; /* 핑크로 변경 */
        }
        .menu a:hover {
            background-color: #001F3F; /* 핑크 계열로 hover 색상 변경 */
            color: #fff;
        }
    </style>
    </sec:authorize>

    <script>
        function showSection(sectionId) {
            // 모든 섹션을 숨김
            var sections = document.querySelectorAll('.section');
            sections.forEach(function (section) {
                section.classList.remove('active');
            });

            // 선택된 섹션을 보여줌
            var targetSection = document.getElementById(sectionId);
            targetSection.classList.add('active');
        }

        window.onload = function () {
            var sectionFromServer = '<%= request.getParameter("section") != null ? request.getParameter("section") : "terms" %>';
            showSection(sectionFromServer);
        };
    </script>
</head>
<body>
    <div class="container">
        <h1 class="title">Vroom_정책</h1>

        <div class="menu">
            <a href="javascript:void(0);" onclick="showSection('terms')">이용약관</a>
            <a href="javascript:void(0);" onclick="showSection('privacy')">개인정보 취급방침</a>
            <a href="javascript:void(0);" onclick="showSection('cookiePolicy')">쿠키 정책</a>
            <a href="javascript:void(0);" onclick="showSection('youthUsagePolicy')">청소년 보호정책</a>
            <a href="javascript:void(0);" onclick="showSection('sitePolicy')">사이트 운영 방식</a>
        </div>

        <div class="section" id="terms">
            <h2>이용약관</h2>
        
	        <h3>제 1조 [목 적]</h3>
	        	<p>본 약관은 대전천변도시고속화도로(이하 "회사"라 합니다.)가 제공하는 대전천변도시고속화도로 홈페이지 서비스(이하 "서비스”라 합니다.)를 이용함에 있어 이용 조건 및 절차에 관한 기본적인 사항을 규정하는 것을 목적으로 합니다.</p>
	        	<br>
	        	
	        <h3>제 2조 [용어의 정의]</h3>
	        	<h4>본 약관에서 사용하는 용어는 다음과 같이 정의합니다.</h4>
	        	<p>
					1. "이용자"라 함은 회사 홈페이지에 접속하여 본 약관에 따라 회사가 제공하는 서비스를 받는 회원 및 비회원을 말합니다.
					<br>2. "회원"이라 함은 회사에 개인정보를 제공하여 이용 계약을 체결하여 이용자 아이디를 부여받은 개인으로, 회사가 제공하는 정보를 지속적으로 제공받으며
						홈페이지 서비스를 계속적으로 이용할 수 있는 자를 말합니다.
					<br>3. "비회원"이라 함은 회원에 가입하지 않고 회사가 제공하는 서비스를 이용하는 자를 말합니다.
					<br>4. "아이디(ID)"라 함은 회원의 식별과 서비스 이용을 위하여 회사가 정하는 기준에 따라 회원 본인이 설정하고 회사가 승인하는 문자 또는 숫자의 조합을 말합니다.
					<br>5. "비밀번호"라 함은 회원이 부여받은 아이디(ID)와 일치되는 회원임을 확인하고 회원의 비밀 보호를 위해 회사가 정하는 기준에 따라 회원 본인이 정한 문자 또는 숫자의 조합을 말합니다.
					<br>6. "해지"라 함은 회사 또는 회원이 서비스 개통 후 이용계약을 해약하는 것을 말합니다.
					<br>7. 운영자 : 서비스의 전반적 관리 운영을 위하여 회사가 선정한 사람 또는 업체
					<br>8. 서비스 중지 : 정상이용 중 회사가 정한 일정한 요건에 따라 일정 기간 동안 서비스의 제공을 중지하는 것
					<br>9. 개인정보 : 개인에 대한 정보로서 성명, 주민등록번호 등의 사항에 의하여 해당 개인을 식별할 수 있는 정보 (다른 정보와 결합하여 식별할 수 있는 경우를 포함)를 말합니다.
				</p>
				<br>
				
	        <h3>제 3조 [약관의 효력 및 변경]</h3>
		        <p>
		        	- 본 약관은 그 내용을 회사가 제공하는 홈페이지 화면에 게시하고 이용자가 동의의 의사표시를 함으로써 효력이 발생됩니다.
					<br>- 회사는 영업상의 중요한 사유나 기타 합리적 사유가 발생할 경우 약관의 규제 등에 관한 법률, 전자거래기본법, 전자서명법, 정보통신망 이용촉진 등에 관한 법률, 소비자보호법 등 관련법을 위배하지 않는 범위에서 본 약관을 개정할 수 있으며, 변경된 약관은 제1항과 같은 방법으로 공지함으로써 효력을 발생하며 기존의 회원에게도 유효하게 효력이 발생합니다.
					<br>- 회원은 변경된 약관 사항에 동의하지 않으면 회사는 회원의 서비스 이용을 중단하고, 이용 계약을 해지할 수 있습니다. 약관의 효력 발생일 이후의 계속적인 서비스 이용은 약관의 변경 사항에 동의한 것으로 간주됩니다.
					<br>- 새로운 서비스가 개설될 경우 별도의 명시된 설명이 없은 한 이 약관에 따라 서비스가 제공됩니다.
				</p>
				<br>
				
	        <h3>제 4조 [이용계약 체결(회원가입) 및 탈퇴]</h3>
	        	<h4>이용계약 체결(회원가입)</h4>
	        	<p>
					<br>1. 회원이 되려고 하는 자는 회사가 정한 가입양식에 따라 회원정보를 기입한 후 이 약관에 동의하여야 합니다.
					<br>2. 회사는 회원가입을 신청한 이용자 중 다음 각 목에 해당하는 자에 대하여 이를 승낙하지 아니할 수 있습니다.
					<br>가. 이름이 실명이 아닌 경우
					<br>나. 다른 사람의 명의를 사용하여 신청하였을 경우
					<br>다. 등록 내용에 허위, 기재 누락, 오기가 있는 경우
					<br>라. 기타 회원가입을 승낙하는 것이 회사의 서비스 제공에 현저히 지장이 있다고 판단되는 경우
					<br>마. 기타 부득이한 사정이 있는 경우
					<br>3. 이용계약의 체결시기는 회사의 승낙이 회원에게 도달한 시점으로 합니다.
					<br>4. 회원은 회원정보가 변경되었을 경우 자신이 직접 홈페이지에서 온라인으로 수정하여야 합니다. 이때 변경하지 않은 정보로 인해 발생되는 문제의 책임은 회원에게 있습니다.
				</p>
					<br>
					<h4>회원 탈퇴 및 이용 제한</h4>
				<p>
					<br>1. 회원은 언제든지 탈퇴를 요청할 수 있으며 이 경우 회사는 바로 회원 탈퇴를 처리합니다.
					<br>2. 회원이 다음 각 목의 어느 하나의 사유에 해당하는 경우, 회사는 회원 자격을 제한하거나 회원 등록을 취소할 수 있습니다.
					<br>가. 제4조제1항제2호에 해당하는 경우
					<br>나. 하이패스카드 사용에 따른 서비스, on-line서비스 이용하여 구입한 재화ㆍ용역 등의 대금, 기타 교통서비스, on-line서비스 이용에 관련하여 회원이 부담하는 채무를 기일에 지급하지 않는 경우
					<br>다. 다른 사람의 서비스 이용을 방해하거나 그 정보를 도용하는 등 전자거래 질서를 위협하는 경우
					<br>라. 그 밖의 관계법령이나 회사가 정한 약관을 위반하거나 회사의 서비스 제공을 방해하는 경우
					<br>3. 회사는 회원자격을 상실하고 이용계약이 해지된 회원이 다시 이용 신청하는 경우 일정기간 그 승낙을 제한할 수 있습니다.
				</p>
				<br>
				
	        <h3>제 5조 [개인 정보 보호]</h3>
		        <p>
		        	- 회사는 회원의 정보 수집 시 정상적인 서비스를 위한 최소한의 정보를 수집합니다.
					<br>- 회사는 서비스와 관련하여 취득한 회원의 개인정보를 해당 회원의 서비스 이용 및 유익한 정보제공을 위해 필요한 경우를 제외하고 다른 목적으로 사용하지 않습니다.
						다만, 다음 각 호의 어느 하나에 해당하는 경우에는 예외로 합니다
					<br>1. 통계 작성, 학술 연구 또는 시장 조사를 위하여 필요한 경우로서 특정 개인을 식별할 수 없는 형태로 제공하는 경우
					<br>2. 관계 법령에 의하여 수사 상의 목적으로 관계기관으로부터 요구받은 경우
					<br>3. 서비스의 제공에 필요한 범위 내에서 제휴기관과 공유해야 하는 경우
					<br>4. 회원과 가맹점이 카드거래로 인하여 분쟁이 발생하여 가맹점에게 회원의 정보제공이 필요한 경우
					<br>5. 기타 관계법령에 의한 경우
				</p>
				<br>
				
	        <h3>제 6조 [서비스 이용]</h3>
	        	<p>
	        		- 회사는 회원의 이용신청을 승낙한 때부터 즉시 서비스를 개시합니다. 또한 서비스의 이용시간은 연중무휴 1일 24시간 이용을 원칙으로 합니다.
					다만, 서비스의 종류 및 내용에 따라 일부의 온라인 서비스는 따로 이용시간을 정할 수 있으며, 이는 온라인 서비스 이용안내에 규정함으로써 해당 시간에만 서비스 이용이 가능합니다.
					<br>- 제1항의 이용시간에 불구하고 통신장애, 서비스개발, 정기점검 등의 불가피한 사유에 의해 서비스 제공이 일정기간 동안 제한되거나 중단될 수 있습니다.
					<br>- 회사는 서비스 이용의 제한을 하고자 하는 경우에는 그 사유, 일시 및 기간을 정하여 인터넷 홈페이지 게시 등의 방법에 의하여 해당 이용자에게 통지합니다.
					다만, 회사가 긴급하게 이용을 정지할 필요가 있다고 인정하는 경우에는 그러하지 아니합니다.
	        	</p>
	        	<br>
	        
	        <h3>제 7조 [서비스 정지 및 제한]</h3>
	        	<p>
	        		- 회사는 전시·사변·천재지변 또는 이에 준하는 국가비상사태가 발생하거나 발생할 우려가 있는 경우와 전기통신사업법에 의한 기간통신사업자가 전기통신서비스를 중지하는 등 기타 부득이한 사유가 있는 경우에는 서비스의 전부 또는 일부를 제한하거나 정지할 수 있습니다.
					<br>- 회사는 제1항의 규정에 의하여 서비스의 이용을 제한하거나 정지한 때에는 그 사유 및 제한기간 등을 지체 없이 회원에게 알려야 합니다.
					<br>- 회사는 회원의 서비스 이용내용이 다음 각 호에 해당하는 경우에는 게시물을 삭제하거나 서비스의 전부 또는 일부의 이용을 제한하거나 정지할 수 있습니다.
					<br>1. 서비스의 안정적인 운영을 방해하는 경우
					<br>2. 타인의 지적재산권을 침해하는 내용을 게시, 게재, 전자메일 또는 기타의 방법으로 전송하는 경우
					<br>3. 타인의 회원ID와 비밀번호를 사용하는 경우4. 서비스정보를 이용하여 얻은 정보를 회사의 사전 승낙 없이 복제 또는 유통시키거나 상업적으로 이용하는 경우
					<br>5. 전기통신 관련법령 등에 위배되는 경우
					<br>6. 다른 회원의 개인정보를 수집 또는 저장하는 경우
					<br>7. 제3자의 권리를 침해하거나 타인을 비방하는 경우
	        	</p>
	        	<br>
	        <h3>[부칙]제 1 조 [시행일]</h3>
	        <h3>이 약관은 2024년 9월 20일부터 시행합니다.</h3>
        </div>

        <div class="section" id="privacy">
            <h2>개인정보 취급방침</h2>
		        <p>
		        	Vroom 개인정보 처리방침.
		        </p>
		        <p>
		        	Vroom(이하 `개인정보위'라 한다)는 정보주체의 자유와 권리 보호를 위해 「개인정보 보호법」 및 관계 법령이 정한 바를 준수하여, 적법하게 개인정보를 처리하고 안전하게 관리하고 있습니다.
					이에 「개인정보 보호법」 제30조에 따라 정보주체에게 개인정보 처리에 관한 절차 및 기준을 안내하고, 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리방침을 수립 ‧ 공개합니다.
				</p>
				<div class="divider"></div>
				
			<h2>1. 개인정보처리방침의 의의</h2>
				<p>
					-Vroom이 어떤 정보를 수집하고, 수집한 정보를 어떻게 사용하며, 필요에 따라 누구와 이를 공유(‘위탁 또는 제공’)하며, 이용목적을 달성한 정보를 언제·어떻게 파기하는지 등 ‘개인정보의 한살이’와 관련한 정보를 투명하게 제공합니다.
				   <br>- 정보주체로서 이용자는 자신의 개인정보에 대해 어떤 권리를 가지고 있으며, 이를 어떤 방법과 절차로 행사할 수 있는지를 알려드립니다. 또한, 법정대리인(부모 등)이 만14세 미만 아동의 개인정보 보호를 위해 어떤 권리를 행사할 수 있는지도 함께 안내합니다.
				   <br>- 개인정보 침해사고가 발생하는 경우, 추가적인 피해를 예방하고 이미 발생한 피해를 복구하기 위해 누구에게 연락하여 어떤 도움을 받을 수 있는지 알려드립니다.
				   <br>- 그 무엇보다도, 개인정보와 관련하여 Vroom과 이용자간의 권리 및 의무 관계를 규정하여 이용자의 ‘개인정보자기결정권’을 보장하는 수단이 됩니다.
				</p>
				<div class="divider"></div>
				
			<h2>2. 수집하는 개인정보</h2>
				<p>
					이용자는 회원가입을 하지 않아도 정보 검색, 뉴스 보기 등 대부분의 Vroom 서비스를 회원과 동일하게 이용할 수 있습니다.
					이용자가 메일, 캘린더, 카페, 블로그 등과 같이 개인화 혹은 회원제 서비스를 이용하기 위해 회원가입을 할 경우, Vroom는 서비스 이용을 위해 필요한 최소한의 개인정보를 수집합니다.
					회원가입 시점에 Vroom가 이용자로부터 수집하는 개인정보는 아래와 같습니다.
				</p>
				<p>
					- 회원 가입 시 필수항목으로 아이디, 비밀번호, 이름, 생년월일, 성별, 휴대전화번호를, 선택항목으로 본인확인 이메일주소를 수집합니다. 실명 인증된 아이디로 가입 시, 암호화된 동일인 식별정보(CI), 중복가입 확인정보(DI), 내외국인 정보를 함께 수집합니다. 만14세 미만 아동의 경우, 법정대리인의 동의를 받고 있으며, 휴대전화번호 또는 아이핀 인증을 통해 법정대리인의 동의를 확인하고 있습니다. 이 과정에서 법정대리인의 정보(법정대리인의 이름, 중복가입확인정보(DI), 휴대전화번호(아이핀 인증인 경우 아이핀번호))를 추가로 수집합니다.
				   <br>- 비밀번호 없이 회원 가입 시에는 필수항목으로 아이디, 이름, 생년월일, 휴대전화번호를, 선택항목으로 비밀번호를 수집합니다.
				   <br>- 단체 회원가입 시 필수 항목으로 단체아이디, 비밀번호, 단체이름, 이메일주소, 휴대전화번호를, 선택항목으로 단체 대표자명을 수집합니다.
				</p>
				<h4>Vroom은 아래의 방법을 통해 개인정보를 수집합니다.</h4>
				<p>
					- 회원가입 및 서비스 이용 과정에서 이용자가 개인정보 수집에 대해 동의를 하고 직접 정보를 입력하는 경우, 해당 개인정보를 수집합니다.
				   <br>- 고객센터를 통한 상담 과정에서 웹페이지, 메일, 팩스, 전화 등을 통해 이용자의 개인정보가 수집될 수 있습니다.
				   <br>- 오프라인에서 진행되는 이벤트, 세미나 등에서 서면을 통해 개인정보가 수집될 수 있습니다.
				   <br>- Vroom와 제휴한 외부 기업이나 단체로부터 개인정보를 제공받을 수 있으며, 이러한 경우에는 개인정보보호법에 따라 제휴사에서 이용자에게 개인정보 제공 동의 등을 받은 후에 Vroom에 제공합니다.
				   <br>- 기기정보와 같은 생성정보는 PC웹, 모바일 웹/앱 이용 과정에서 자동으로 생성되어 수집될 수 있습니다.
				</p>
				<div class="divider"></div>
				
			<h2>3. 수집한 개인정보의 이용</h2>
				<h4>Vroom 및 Vroom 관련 제반 서비스(모바일 웹/앱 포함)의 회원관리, 서비스 개발·제공 및 향상, 안전한 인터넷 이용환경 구축 등 아래의 목적으로만 개인정보를 이용합니다.</h4>
				<p>
					- 회원 가입 의사의 확인, 연령 확인 및 법정대리인 동의 진행, 이용자 및 법정대리인의 본인 확인, 이용자 식별, 회원탈퇴 의사의 확인 등 회원관리를 위하여 개인정보를 이용합니다.
				   <br>- 콘텐츠 등 기존 서비스 제공(광고 포함)에 더하여, 인구통계학적 분석, 서비스 방문 및 이용기록의 분석, 개인정보 및 관심에 기반한 이용자간 관계의 형성, 지인 및 관심사 등에 기반한 맞춤형 서비스 제공 등 신규 서비스 요소의 발굴 및 기존 서비스 개선 등을 위하여 개인정보를 이용합니다. 신규 서비스 요소의 발굴 및 기존 서비스 개선 등에는 정보 검색, 다른 이용자와의 커뮤니케이션, 콘텐츠 생성·제공·추천, 상품 쇼핑 등에서의 인공지능(AI) 기술 적용이 포함됩니다.
				   <br>- 법령 및 Vroom 이용약관을 위반하는 회원에 대한 이용 제한 조치, 부정 이용 행위를 포함하여 서비스의 원활한 운영에 지장을 주는 행위에 대한 방지 및 제재, 계정도용 및 부정거래 방지, 약관 개정 등의 고지사항 전달, 분쟁조정을 위한 기록 보존, 민원처리 등 이용자 보호 및 서비스 운영을 위하여 개인정보를 이용합니다.
				   <br>- 유료 서비스 제공에 따르는 본인인증, 구매 및 요금 결제, 상품 및 서비스의 배송을 위하여 개인정보를 이용합니다.
				   <br>- 이벤트 정보 및 참여기회 제공, 광고성 정보 제공 등 마케팅 및 프로모션 목적으로 개인정보를 이용합니다.
				   <br>- 서비스 이용기록과 접속 빈도 분석, 서비스 이용에 대한 통계, 서비스 분석 및 통계에 따른 맞춤 서비스 제공 및 광고 게재 등에 개인정보를 이용합니다.
				   <br>- 보안, 프라이버시, 안전 측면에서 이용자가 안심하고 이용할 수 있는 서비스 이용환경 구축을 위해 개인정보를 이용합니다.
				</p>
				<h4>Vroom는 수집한 개인정보를 특정 개인을 알아볼 수 없도록 가명처리하여 통계작성, 과학적 연구, 공익적 기록 보존 등을 위하여 처리할 수 있습니다. 이 때 가명정보는 재식별되지 않도록 추가정보와 분리하여 별도 저장·관리하고 필요한 기술적·관리적 보호조치를 취합니다</h4>
        </div>

        <div class="section" id="cookiePolicy">
            <h2>쿠키 정책</h2>
	        <p>
	        	이 쿠키 정책(“쿠키 정책“, “정책“)은 각 관련 웹사이트에 명시된 대로 AMETEK, Inc. 또는 그 계열사(“우리“, “당사“, “당사의”)에서 운영하고 이 쿠키 정책이 연결된 모든 웹사이트(“웹사이트“, “서비스“)에서 제공되는 쿠키에 적용됩니다.
	        </p>
        	<h2>쿠키란?</h2>
	        	<p>
	        		쿠키는 사용자가 인터넷에서 특정 페이지에 방문했을 때 컴퓨터 또는 모바일/휴대형 기기(예: 스마트폰 또는 태블릿)에 저장되는 파일입니다. 쿠키에는 웹 서버가 웹 브라우저에 보내고 브라우저가 저장하는 식별자(문자와 숫자의 문자열)를 포함되어 있습니다. 브라우저는 브라우저가 서버에서 페이지를 요청할 때마다 식별자를 서버로 다시 보냅니다.
					<br>쿠키는 “영구” 쿠키 또는 “세션” 쿠키일 수 있습니다. 영구 쿠키는 웹 브라우저에 저장되며 만료 날짜 전에 사용자가 삭제하지 않는 한 설정된 만료 날짜까지 유효합니다. 반면에 세션 쿠키는 사용자가 웹 브라우저를 닫을 때 만료됩니다.
					<br>“퍼스트 쿠키”는 방문 중인 웹사이트 또는 애플리케이션에서 설정되며, 해당 사이트 또는 애플리케이션으로만 읽을 수 있습니다.
					<br>“서드 파티 쿠키”는 방문 중인 웹사이트나 애플리케이션의 소유자에 의해 설정되지 않고, 다른 조직에서 설정한 것입니다. 예를 들어, 사용자가 당사 웹사이트의 링크를 클릭했을 때 광고주나 그 밖에 제3의 업체가 자사 쿠키를 사용할 수도 있고, 당사가 타사 분석 업체와 계약을 맺었을 때 해당 업체가 이 서비스를 수행하기 위해 자체 쿠키를 설정했을 수 있습니다.
	        	</p>
        	<h2>웹 사이트의 쿠키</h2>
	        	<p>
	        		당사 웹사이트 중 하나에서 사용되는 쿠키에 대한 전체 정보는 해당 웹사이트의 쿠키 기본 설정 센터에서 확인할 수 있습니다.
	        	</p>
        	<h2>꼭 필요한 쿠키</h2>
        		<p>
        			꼭 필요한 쿠키는 웹사이트가 기본적인 기능을 제공하기 위해 반드시 있어야 하는 쿠키로 분류됩니다. 이 쿠키는 웹사이트 기능에 액세스하는 데 필수적이며 사용자 측에서 이러한 쿠키를 선택하거나 선택 해제할 수 없습니다. 사용자는 브라우저에서 이러한 쿠키를 차단하거나 알림을 제공하도록 설정할 수 있지만, 웹사이트의 일부 기능은 이러한 유형의 쿠키를 차단할 경우 작동하지 않을 수 있습니다.
        		</p>
        	<h2>성능 쿠키</h2>
        		<p>
        			당사의 모든 웹사이트가 성능 쿠키를 사용하는 것은 아닙니다. 성능 쿠키를 사용하는 당사 웹사이트는 쿠키 기본 설정 센터에 이러한 사실을 명시합니다. 성능 쿠키는 특히, 방문자가 웹사이트를 사용하는 방식, 가장 자주 방문하는 웹사이트 페이지 또는 웹페이지에서 오류 메시지를 받았는지 여부에 대한 데이터를 수집하는 데 사용되는 쿠키입니다. 또한 성능 쿠키는 방문자 수, 페이지에 머문 시간, 웹사이트를 이용할 때 웹사이트 간을 이동한 방법에 관한 정보를 인식하여 수집합니다. 이러한 모든 정보는 웹사이트 작동 방식을 개선하는 데 도움이 됩니다. 예를 들어, 방문자가 찾고 있는 항목을 쉽게 찾을 수 있게 해줍니다. 이러한 유형의 쿠키를 동의하지 않을 경우, 당사가 사용자의 방문으로부터 얻은 정보를 바탕으로 웹사이트를 개선할 수 없게 됩니다. 이 쿠키는 사용자가 사이트와 상호 작용할 때 사이트의 성능만 모니터링합니다.
        		</p>
        	<h2>기능 쿠키</h2>
        		<p>
        			당사의 모든 웹사이트가 기능 쿠키를 사용하는 것은 아닙니다. 기능 쿠키를 사용하는 당사 웹사이트는 쿠키 기본 설정 센터에 이러한 사실을 명시합니다. 기능 쿠키를 사용하면 웹사이트에서 사용자의 사이트 기본 설정과 사용자 이름, 지역, 언어를 포함하여 사이트에서 선택한 내용을 기억할 수 있습니다. 기능 쿠키를 거부하면 당사가 일부 또는 전체 환경설정과 사용자 선택에 대해 효과를 제공하지 못할 수 있습니다.
        		</p>
        	<h2>타겟팅 쿠키</h2>
        		<p>
        			타겟팅 쿠키(광고 쿠키 포함)는 당사 웹사이트 안팎에서 관심 있는 관련 주제를 기반으로 광고 및 콘텐츠를 표시 (“타겟팅”)하기 위해 장치에서 정보를 수집하도록 특별히 설계되었습니다. 당사의 모든 웹사이트가 타겟팅 쿠키를 사용하는 것은 아닙니다. 타겟팅 쿠키를 사용하는 당사 웹사이트는 쿠키 기본 설정 센터에 이러한 사실을 명시합니다. 이러한 쿠키는 사용자의 웹사이트 방문, 방문한 페이지, 팔로우한 링크를 포함하여 사용자의 온라인 활동에 관한 데이터를 수집합니다. 또한 사용자의 관심 사항을 식별하므로 이를 바탕으로 당사가 사용자와 관련이 있을 것으로 판단되는 광고를 제공할 수 있습니다. 당사는 이 정보를 사용해 사용자와 관심도에 보다 관련이 있도록 웹사이트 및 사이트에 표시되는 타겟팅, 사용자에게 발송하는 마케팅 메시지를 조정할 수 있습니다. 또한 이러한 목적으로 당사에 서비스를 제공하는 제3자와 이 정보를 공유할 수도 있습니다. 더불어 사용자가 광고를 보는 횟수를 제한할 뿐 아니라 타겟팅 효과를 측정하고, 어떤 타겟팅 소스가 방문자들이 당사 웹사이트를 방문하도록 유도하는지를 파악하는 데 사용될 수 있고, 이를 통해 특정 타겟팅 소스에 투자하는 것이 가치가 있는 일인지를 알 수 있습니다. 
					<br><br>이러한 쿠키는 타사 타겟팅 파트너가 당사 웹사이트를 통해 설정할 수 있습니다. 귀하의 관심사에 대한 프로필을 파악하고 다른 사이트에서 귀하에게 관련 광고를 표시하기 위해 해당 파트너가 사용할 수 있습니다. 이들은 직접적으로 개인 정보를 저장하지 않지만 귀하의 브라우저와 인터넷 장치를 고유하게 식별하는 방식에 기반을 둡니다. 사용자가 이러한 쿠키 유형에 동의하지 않을 경우, 타겟팅이 줄어든 광고를 보게 됩니다(전체적으로 광고가 줄어들지는 않음).
        		</p>
        	<h2>쿠키 기본 설정</h2>
        		<p>
        			꼭 필요한 쿠키를 제외하고 쿠키 기본 설정 센터를 통해 쿠키 기본 설정을 관리할 수 있습니다. 쿠키 기본 설정 센터는 쿠키 허용에 대한 기본 설정을 기록합니다. 쿠키 기본 설정 센터는 당사 웹사이트를 방문할 때 설정되는 타겟팅 쿠키, 기능 쿠키 및 성능 쿠키를 구체적으로 제어합니다. 꼭 필요한 쿠키는 비활성화할 수 없으며 이 도구를 사용하여 당사 웹사이트에서 액세스할 수 있는 제3자 웹사이트의 쿠키를 차단할 수도 없습니다.
					<br><br>귀하는 언제든지 쿠키 기본 설정 센터에 액세스할 수 있습니다. 첫 방문 시, “내 쿠키 기본 설정 관리” 버튼을 클릭하면 제공되는 대화 상자에서 쿠키 기본 설정 센터에 액세스할 수 있습니다. 이후에는 화면의 하단 왼쪽 모서리에 있는 쿠키 아이콘을 클릭해서 쿠키 기본 설정 센터에 액세스할 수 있습니다.
        		</p>
        </div>

        <div class="section" id="youthUsagePolicy">
            <h3>청소년보호정책</h3>
        	<p>
        		Vroom은 청소년들이 유해한 환경으로부터 보호될 수 있도록 건전한 서비스 이용환경을 조성하고자 노력하고 있습니다.
        	</p>
        	<div class="divider"></div>
        	<h3>1. 청소년 보호정책의 목표</h3>
	        	<p>
	        		Vroom(이하 회사)는 청소년들이 유해한 환경으로부터 보호될 수 있도록 건전한 서비스 이용환경을 조성합니다.
	        	</p>
        	<h3>2. 청소년의 권익보호</h3>
        		<p>
	        		1) 유해한 환경으로부터 보호 받을 권리
					<br>회사는 청소년의 건강을 해치거나 해칠 우려가 있는 환경으로부터 청소년이 보호받을 수 있도록 조치합니다.
					<br>2) 개인정보를 보호 받을 권리
					<br>회사는 회사의 개인정보보호정책에 따라 청소년의 개인정보를 취급, 관리 하고 있습니다.
					<br>청소년들에게 원활하고 안정적인 서비스를 제공하기 위해 회원으로 가입시 최소한의 범위 안에서 적법하고 정당하게 개인정보를 수집하며, 목적 외의 용도로 활용하지 않습니다. 또한 수집된 개인정보는 안전하게 관리되도록 최선의 조치를 취합니다.
					<br>아동의 법정대리인 또는 청소년은 당해 아동 또는 자신의 개인정보에 대한 열람 및 정정요구를 할 수 있습니다.
	        	</p>
        	<h3>3. 청소년의 접근제한 및 관리조치</h3>
        		<p>
        			회사는 청소년에게 적합한 서비스를 제공하기 위해 접근 제한 및 관리조치를 시행합니다.
					<br>1) 연령 등급 서비스 제공
					<br>회사는 청소년들이 연령에 적합한 서비스를 이용할 수 있도록 조치합니다. 회사에서 제공하는 게임물은 이용자의 연령을 확인하여이용할 수 있도록 조치하며, 청소년이용불가게임물에 대한 접근을 차단합니다.
					<br>2) 실명 및 본인 인증 제도 시행
					<br>이용자가 회사에서 제공하는 서비스를 이용하기 위해서는 실명 및 본인인증 절차를 거치도록 하여 연령 등급에 맞지 않는 서비스를 이용하거나 청소년유해매체물에 노출되지 않도록 절차적으로 차단합니다.
					<br>3) 법정대리인의 동의 획득
					<br>회사는 14세 미만의 아동이 회사의 서비스 등을 이용하고자 이용을 요청할 경우, 법정대리인의 동의를 받아 이용신청을 승낙합니다. 또한 청소년들이 요금결제 등 의무부담행위를 하고자 할 때에도 법정대리인의 동의를 받도록 합니다.
					<br>4) 금칙어 적용
					<br>회사는 청소년의 건전한 언어습관을 위해 욕설, 폭력적선정적 표현 등에 금칙어를 적용합니다.
					<br>5) 필터링 시스템 가동
					<br>회사는 대화창에 욕설이나 은어, 비속어 등을 입력할 경우 필터링 조치를 취합니다.
					<br>6) 불건전 정보 모니터링 시행
					<br>회사는 불건전한 정보로부터 청소년을 보호하기 위해 24시간 모니터링을 시행합니다.
					<br>7) 광고선전의 제한
					<br>회사는 청소년들이 유해한 광고물(성인광고, 유해물질 등) 에 노출되지 않도록 광고선전의 내용을 제한합니다.
					<br>8) 공서양속을 저해하는 행위에 대한 제재
					<br>회사는공공정보 또는 미풍양속을 저해하는 사항들에 대해서는 제재조치들을 취합니다.
					<br>9) 결제한도의 적용
					<br>회사는 청소년들이 과도한 결제 방지를 위해 월 유료 결제한도를 설정하여 적용, 운영합니다.
					<br>10) 결제정보 및 게임이용정보의 제공
					<br>회사는 청소년 이용자의 결제 내역을 법정대리인에게 매월 제공합니다. 또한 법정대리인의 요청이 있을 경우 당해 청소년의 게임이용 내용 및 결제 내역을 확인할 수 있도록 지원합니다.
					<br>11) 장시간 게임이용 방지를 위한 주의 문구의 게시
					<br>회사는 청소년의 장시간 게임이용 방지를 위해 게임실행 초기화면에 주의 문구를 게시합니다. 또한 게임 이용 중에 이용 시간의 경과를 알리는 문구를 정기적으로 게시합니다.
        		</p>
        	<h3>4. 유해정보로 인한 피해상담 및 고충처리</h3>
        		<p>
        			회사는 유해정보로부터 청소년을 보호하기 위해 최선의 노력을 합니다. 회사는 유해정보로 인한 피해상담 및 고충처리, 청소년 보호에 대한 의견 수렴 및 불만처리를 위한 창구를 제공합니다.
        		</p>
        	<h3>5. 청소년보호를 위한 인터넷기업 윤리강령 및 실천지침 준수</h3>
        		<p>
        			회사는 청소년보호를 위해 인터넷기업 윤리강령 및 실천지침을 준수합니다.
        		</p>
        </div>

        <div class="section" id="sitePolicy">
             <h2>사이트 운영 방식</h2>
        <p>본 사이트는 이용자에게 최상의 서비스를 제공하기 위해 다양한 운영 방침을 따릅니다. 이용자는 이를 숙지하고 이용해 주시기 바랍니다.</p>
        <p>... (상세 내용) ...</p>
        </div>
    </div>
</body>
</html>
