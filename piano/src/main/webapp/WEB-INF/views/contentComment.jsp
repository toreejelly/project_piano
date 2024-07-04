<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
<div class="container bootdey">
<div class="col-md-12 bootstrap snippets">

<!-- 댓글 작성 -->
<div class="panel">	
  <div class="panel-body">
    <textarea class="form-control" rows="2" placeholder="댓글을 작성해주세요"></textarea>
    <div class="mar-top clearfix">
      <button class="btn btn-sm btn-primary pull-right" type="submit"><i class="fa fa-pencil fa-fw"></i>작성</button>
    </div>
  </div>
</div>
<div class="panel">
    <div class="panel-body">
    <!-- 댓글 -->
    <!--===================================================-->
    <div class="media-block">
      <a class="media-left" href="#"><img class="img-circle img-sm" alt="Profile Picture" src="https://bootdey.com/img/Content/avatar/avatar1.png"></a>
      <div class="media-body">
        <div class="mar-btm">
          <a href="#" class="btn-link text-semibold media-heading box-inline">닉네임</a>
          <p class="text-muted text-sm">작성 시간</p>
        </div>
        <p>댓글내용</p>
        <div class="pad-ver">
          <div class="btn-group">
            <a class="btn btn-sm btn-default btn-hover-success" href="#"><i class="fa fa-thumbs-up"></i></a>
            <a class="btn btn-sm btn-default btn-hover-danger" href="#"><i class="fa fa-thumbs-down"></i></a>
          </div>
          <a class="btn btn-sm btn-default btn-hover-primary" href="#">댓글</a>
        </div>
        <hr>

        <!-- 대댓글 -->
        <div>
          <div class="media-block">
            <a class="media-left" href="#"><img class="img-circle img-sm" alt="Profile Picture" src="https://bootdey.com/img/Content/avatar/avatar2.png"></a>
            <div class="media-body">
              <div class="mar-btm">
                <a href="#" class="btn-link text-semibold media-heading box-inline">대댓글 닉네임</a>
                <p class="text-muted text-sm">작성 시간</p>
              </div>
              <p>대댓글 내용</p>
              <div class="pad-ver">
                <div class="btn-group">
                  <a class="btn btn-sm btn-default btn-hover-success active" href="#"><i class="fa fa-thumbs-up"></i> You Like it</a>
                  <a class="btn btn-sm btn-default btn-hover-danger" href="#"><i class="fa fa-thumbs-down"></i></a>
                </div>
                <a class="btn btn-sm btn-default btn-hover-primary" href="#">Comment</a>
              </div>
              <hr>
            </div>
          </div>

          <div class="media-block">
            <a class="media-left" href="#"><img class="img-circle img-sm" alt="Profile Picture" src="https://bootdey.com/img/Content/avatar/avatar3.png">
            </a>
            <div class="media-body">
              <div class="mar-btm">
                <a href="#" class="btn-link text-semibold media-heading box-inline">Lucy Moon</a>
                <p class="text-muted text-sm"><i class="fa fa-globe fa-lg"></i> - From Web - 2 min ago</p>
              </div>
              <p>Duis autem vel eum iriure dolor in hendrerit in vulputate ?</p>
              <div class="pad-ver">
                <div class="btn-group">
                  <a class="btn btn-sm btn-default btn-hover-success" href="#"><i class="fa fa-thumbs-up"></i></a>
                  <a class="btn btn-sm btn-default btn-hover-danger" href="#"><i class="fa fa-thumbs-down"></i></a>
                </div>
                <a class="btn btn-sm btn-default btn-hover-primary" href="#">Comment</a>
              </div>
              <hr>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!--===================================================-->
    <!-- End Newsfeed Content -->

  </div>
</div>
</div>
</div>


</body>
</html>