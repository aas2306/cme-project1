<home>

    <header>
        <div class="container-fluid">
          <div class="row">
            <div class="col-5" onclick={ goHome }>
              <h1>speak out</h1>
              <p class="lead">víctimas de abuso: no estas sola</p>
            </div>
            <div class="col-7">
              <button class="navbtns" onclick={showForumPage}>Ir a Foros</button>
              <button class="navbtns"><a href="http://www.mujer.gob.do/index.php/servicios" target="_blank">Buscar Ayuda</a></button>
            </div>
          </div>
        </div>
    </header>

    <div if={showHomeTable} class="infographic">
      <img src="infographic.png" alt="Infographic">
    </div>

      <forums if={ showForums }></forums>
    </div>

    <user-profile if={userprofile}></user-profile>


    <script>
        var that = this;
        that.showHomeTable = true;
        that.showForums = false;
        this.user = firebase.auth().currentUser;
        that.userprofile = false;

        that.goHome = function() {
          that.showHomeTable = true;
          that.showForums = false;
          that.userprofile = false;
          that.update();
        }

        that.showForumPage = function () {
            that.showForums = true;
            that.showHomeTable = false;
            that.userprofile = false;
            that.update();
        }
        that.goToProf = function() {
          that.userprofile = true;
          that.showHomeTable = false;
          that.showForums = false;
          that.update();
        }
    </script>

    <style>
        header {
          padding: 50px 0px 40px 110px;
          align-items: right;
        }
        a {
          color: white;
        }
        .infographic {
          background-color: #91B3BC;
          position: absolute;
          width: 100%;
          height: 1100px;
        }
        .infographic img {
          display: block;
          margin-left: auto;
          margin-right: auto;
        }
        .navbtns {
          background-color: #5B7D87;
          color: white;
          padding: 8px;
          margin: 0px;
          font-size: 19px;
        }

    </style>
</home>
