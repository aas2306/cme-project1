<home>

    <header class="site-header py-5 mb-4">
        <div onclick={ goHome } class="container">
            <h1>speak out</h1>
            <p class="lead">abuse victims: you are not alone</p>
        </div>
    </header>

    <div if={ showHomeTable } class="container-fluid main-content">
        <div class="row">
            <div class="col homeColumn">
                <p>Info + Stats</p>
            </div>
            <div class="col homeColumn" onClick={ showForumPage } style="margin: 0px -2px 0px -2px;">
                <!-- HERE!! -->
                <span>Forums / Community</span>
            </div>
            <div class="col homeColumn">
                Get Help
            </div>
        </div>
    </div>

    <forums if={ showForums }></forums>

    <script>
        var that = this;
        that.showHomeTable = true;
        that.showForums = false;
        this.user = firebase.auth().currentUser;

        that.goHome = function() {
          that.showHomeTable = true;
          that.showForums = false;
        }

        that.showForumPage = function () {
            that.showForums = true;
            that.showHomeTable = false;
            that.update();
        }
    </script>

    <style>
        .homeColumn {
            border: black solid 2px;
            margin: 0;
            height: 300px;
            background-color: #91B3BC;
            color: #2E323C;
            font-family: "Raleway", sans-serif;
            font-weight: 600;
            font-size: 25px;
            text-align: center;
        }

    </style>
</home>
