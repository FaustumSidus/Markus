/**
 NoticeJs.js
 	var noticeSock = new SockJS('noticeSocket');
    	noticeSock.onopen = function() {
    	    console.log('noticeSocket 접속');
    	    noticeCheck();
    	};

    	noticeSock.onmessage = function(e) {
    	    noticeAlert(e.data);
    	};

    	noticeSock.onclose = function() {
 	   	   console.log('noticeSocket 접속해제');
    	};
    	function noticeAlert(msgObj){
    		toastr.info("새 글 등록");
    	}
    	function sendTest(){
    		noticeSock.send("test");
    	}
 */
 	function connectNotice(noticeMsg){
    		var noticeSock = new SockJS('noticeSocket');
        	noticeSock.onopen = function() {
        	    console.log('noticeSocket 접속');
        	    if(noticeMsg.length>0){
        	    	noticeSock.send(noticeMsg);
        	    }
        	};

        	noticeSock.onmessage = function(e) {
        	    noticeAlert(e.data);
        	    //toastr 호출 알람 출력
        	};

        	noticeSock.onclose = function() {
     	   	   console.log('noticeSocket 접속해제');
        	};
        	return noticeSock;
    }
 	function noticeAlert(msgJson){
    		let msgObj = JSON.parse(msgJson);
    		let mType = msgObj.msgType;
    		switch(mType){
    		case "reply":
    			toastr.options.onclick = function() {
    			location.href='/controller/boardView?bno='+msgObj.msgComm;
    			}
    			toastr.success(msgObj.msgComm+"번 글에 댓글 등록.");
    			break;
    		case "board":
    			toastr.options.onclick = function() {
    			location.href='/controller/boardList';
    			}
    			toastr.info(msgObj.msgComm);
    			break;
    		}
    }
 	function sendTest(){
 			let noticeObj = {"noticeType":"board"};
    		noticeSock.send(JSON.stringify(noticeObj));
    	}

 	
 	
 	