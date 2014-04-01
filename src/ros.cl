;;will play w/:https://github.com/ros/roslisp.git &re: bobak@balisp.org
;*<40 j17precise64: /roslisp/lnk> ls bin*
;binf@  bing@  binh@
;*<41 j17precise64: /roslisp/lnk> ls bin*/*
;binf/add_gaussian_noise*              binf/rosmake*                   binh/convert_octree*
;binf/boundary_estimation*             binf/rosmaster*                 binh/edit_octree*
;binf/catkin-build-debs-of-workspace*  binf/rosmsg*                    binh/eval_octree_accuracy*
;binf/catkin-bump-version*             binf/rosmsg-proto*              binh/graph2tree*
;binf/catkin_install_parse*            binf/rosnode*                   binh/log2graph*
;binf/catkin-parse-stack*              binf/rospack*                   binh/opencv_createsamples*
;binf/catkin-topological-order*        binf/rosparam*                  binh/opencv_haartraining*
;binf/catkin_util.sh*                  binf/rosrun*                    binh/opencv_performance*
;binf/catkin-version*                  binf/rosservice*                binh/opencv_traincascade*
;binf/cluster_extraction*              binf/rossrv*                    binh/plugin_macro_update*
;binf/compute_cloud_error*             binf/rosstack*                  binh/rosbag*
;binf/concatenate_points_pcd*          binf/rostest*                   binh/rosboost-cfg*
;binf/convert_pcd_ascii_binary*        binf/rostopic*                  binh/rosclean*
;binf/crop_to_hull*                    binf/rosunit*                   binh/roscore*
;binf/elch*                            binf/roswtf*                    binh/roscreate-pkg*
;binf/extract_feature*                 binf/rxbag*                     binh/rosdoc_lite*
;binf/flann_example_c*                 binf/rxconsole*                 binh/rosgraph*
;binf/fpfh_estimation*                 binf/rxgraph*                   binh/roslaunch*
;binf/gen_cpp.py*                      binf/rxloggerlevel*             binh/roslaunch-complete*
;binf/gen_lisp.py*                     binf/rxplot*                    binh/roslaunch-deps*
;binf/genmsg_py.py*                    binf/spin_estimation*           binh/roslaunch-logs*
;binf/gensrv_py.py*                    binf/swig*                      binh/roslisp_repl*
;binf/git-catkin*                      binf/timed_trigger_test*        binh/rosmake*
;binf/git-catkin-track-all*            binf/transform_point_cloud*     binh/rosmaster*
;binf/gp3_surface*                     binf/vfh_estimation*            binh/rosmsg*
;binf/icp*                             binf/virtual_scanner*           binh/rosmsg-proto*
;binf/icp2d*                           binf/voxel_grid*                binh/rosnode*
;binf/marching_cubes_reconstruction*   bing/catkin_find*               binh/rospack*
;binf/mesh2pcd*                        bing/catkin_init_workspace*     binh/rosparam*
;binf/mesh_sampling*                   bing/catkin_make*               binh/rosrun*
;binf/normal_estimation*               bing/catkin_make_isolated*      binh/rosservice*
;binf/octree_viewer*                   bing/catkin_package_version*    binh/rossrv*
;binf/outlier_removal*                 bing/catkin_prepare_release*    binh/rosstack*
;binf/passthrough_filter*              bing/catkin_test_results*       binh/rostest*
;binf/pcd2ply*                         bing/catkin_topological_order*  binh/rostopic*
;binf/pcd2vtk*                         bing/rospack*                   binh/rosunit*
;binf/pcd_convert_NaN_nan*             bing/rosstack*                  binh/roswtf*
;binf/pcd_viewer*                      binh/binvox2bt*                 binh/rqt*
;binf/plane_projection*                binh/bt2vrml*                   binh/rqt_bag*
;binf/registration_visualizer*         binh/catkin_find*               binh/rqt_console*
;binf/rosbag*                          binh/catkin_init_workspace*     binh/rqt_graph*
;binf/rosboost-cfg*                    binh/catkin_make*               binh/rqt_image_view*
;binf/rosclean*                        binh/catkin_make_isolated*      binh/rqt_logger_level*
;binf/roscore*                         binh/catkin_package_version*    binh/rqt_plot*
;binf/roscreate-pkg*                   binh/catkin_prepare_release*    binh/stage*
;binf/rosgraph*                        binh/catkin_test_results*       binh/tf_remap*
;binf/roslaunch*                       binh/catkin_topological_order*  binh/urdf_mem_test*
;binf/roslaunch-deps*                  binh/check_urdf*                binh/urdf_to_graphiz*
;binf/roslaunch-logs*                  binh/compare_octrees*           binh/view_frames*
;
;binh/bfl:
;test_compare_filters*  test_kalman_smoother*  test_nonlinear_kalman*
;test_discrete_filter*  test_linear_kalman*    test_nonlinear_particle*
;*<42 j17precise64: /roslisp/lnk> ll
;total 4.0K
;lrwxrwxrwx 1 vagrant  14 Jan 17 07:37 binf -> ros/fuerte/bin/
;lrwxrwxrwx 1 vagrant  14 Jan 17 07:37 bing -> ros/groovy/bin/
;lrwxrwxrwx 1 vagrant  13 Jan 17 07:37 binh -> ros/hydro/bin/
;lrwxrwxrwx 1 vagrant  24 Jan 17 07:33 fuerte -> ros/fuerte/share/roslisp/
;lrwxrwxrwx 1 vagrant  24 Jan 17 07:33 groovy -> ros/groovy/share/roslisp/
;lrwxrwxrwx 1 vagrant  23 Jan 17 07:33 hydro -> ros/hydro/share/roslisp/
;-rw-rw-r-- 1 vagrant 110 Jan 17 07:32 note
;lrwxrwxrwx 1 vagrant   8 Jan 17 07:32 ros -> /opt/ros/ 
;
;knowrob/   roboearth/ ros-0.4.3@ ros-code/  rosdistro/
;=have ros installed on a vagrant virtualbox image:
;The following NEW packages will be installed:
; alsa-base alsa-utils autotools-dev blt build-essential cmake cmake-data collada-dom-dev
; collada-dom2.4-dp-base collada-dom2.4-dp-dev comerr-dev cpp-4.4 debhelper dh-apparmor doc-base
; docgenerator docutils-common docutils-doc doxygen doxygen-latex dpkg-dev fakeroot ffmpeg
; fltk1.3-doc fluid fonts-liberation freeglut3 freeglut3-dev g++ g++-4.4 g++-4.6 gazebo gcc-4.4
; gcc-4.4-base gccxml generatorrunner gettext gir1.2-atk-1.0 gir1.2-freedesktop
; gir1.2-gdkpixbuf-2.0 gir1.2-gtk-2.0 gir1.2-pango-1.0 glib-networking glib-networking-common
; glib-networking-services graphviz gsettings-desktop-schemas gstreamer0.10-alsa
; gstreamer0.10-plugins-base gstreamer0.10-plugins-good gstreamer0.10-x hddtemp html2text
; intltool-debian krb5-multidev lacheck latex-beamer latex-xcolor libaa1 libalgorithm-diff-perl
; libalgorithm-diff-xs-perl libalgorithm-merge-perl libapiextractor-dev libapiextractor0.10 libapr1
; libapr1-dev libaprutil1 libaprutil1-dev libarchive12 libart-2.0-2 libasound2-dev libassimp-dev
; libassimp2 libasyncns0 libatk1.0-dev libaudio2 libav-tools libavahi-client-dev
; libavahi-common-dev libavc1394-0 libavcodec-dev libavcodec53 libavdevice53 libavfilter2
; libavformat-dev libavformat53 libavutil-dev libavutil51 libblas3gf libboost-all-dev
; libboost-date-time-dev libboost-date-time1.46-dev libboost-date-time1.46.1 libboost-dev
; libboost-filesystem-dev libboost-filesystem1.46-dev libboost-filesystem1.46.1 libboost-graph-dev
; libboost-graph-parallel-dev libboost-graph-parallel1.46-dev libboost-graph-parallel1.46.1
; libboost-graph1.46-dev libboost-graph1.46.1 libboost-iostreams-dev libboost-iostreams1.46-dev
; libboost-math-dev libboost-math1.46-dev libboost-math1.46.1 libboost-mpi-dev
; libboost-mpi-python-dev libboost-mpi1.46-dev libboost-mpi1.46.1 libboost-program-options-dev
; libboost-program-options1.46-dev libboost-program-options1.46.1 libboost-python-dev
; libboost-python1.46-dev libboost-python1.46.1 libboost-regex-dev libboost-regex1.46-dev
; libboost-regex1.46.1 libboost-serialization-dev libboost-serialization1.46-dev
; libboost-serialization1.46.1 libboost-signals-dev libboost-signals1.46-dev libboost-signals1.46.1
; libboost-system-dev libboost-system1.46-dev libboost-system1.46.1 libboost-test-dev
; libboost-test1.46-dev libboost-test1.46.1 libboost-thread-dev libboost-thread1.46-dev
; libboost-thread1.46.1 libboost-wave-dev libboost-wave1.46-dev libboost-wave1.46.1
; libboost1.46-dev libbullet libbullet-dev libbz2-dev libcaca-dev libcaca0
; libcairo-script-interpreter2 libcairo2-dev libcdparanoia0 libcdt4 libcegui-mk2-0.7.5
; libcegui-mk2-dev libcgraph5 libcppunit-1.12-1 libcppunit-dev libcurl4-openssl-dev libdbus-1-dev
; libdc1394-22 libdevil-dev libdevil1c2 libdpkg-perl libdrm-dev libdrm-nouveau2 libdv4
; libeigen3-dev libexpat1-dev libflac8 libflann-dev libflann1 libfltk-forms1.3 libfltk-images1.3
; libfltk1.1 libfltk1.1-dev libfltk1.3 libfontconfig1-dev libfontenc1 libfreeimage-dev
; libfreeimage3 libfreetype6-dev libgail18 libgcrypt11-dev libgdk-pixbuf2.0-dev libgenrunner-dev
; libgenrunner0.6 libgeos-3.2.2 libgeos-c1 libgettextpo0 libgfortran3 libgl1-mesa-dev
; libgl1-mesa-dri libgl1-mesa-glx libgl2ps-dev libgl2ps0 libglade2-0 libglapi-mesa libglew1.6
; libglib2.0-bin libglib2.0-data libglib2.0-dev libglu1-mesa libglu1-mesa-dev
; libgnome-keyring-common libgnome-keyring0 libgnomecanvas2-0 libgnomecanvas2-common libgnutls-dev
; libgnutls-openssl27 libgnutlsxx27 libgpg-error-dev libgraph4 libgsl0ldbl libgsm1 libgssrpc4
; libgstreamer-plugins-base0.10-0 libgstreamer0.10-0 libgtest-dev libgtk2.0-0 libgtk2.0-bin
; libgtk2.0-common libgtk2.0-dev libgudev-1.0-0 libgvc5 libgvpr1 libhdf5-serial-1.8.4
; libibverbs-dev libibverbs1 libice-dev libicu-dev libicu48 libidn11-dev libiec61883-0 libilmbase6
; libjack-jackd2-0 libjasper-dev libjpeg-dev libjpeg-turbo8-dev libjpeg8-dev libjs-jquery
; libjs-sphinxdoc libjs-underscore libjson0 libkadm5clnt-mit8 libkadm5srv-mit8 libkdb5-6 libkms1
; libkpathsea5 libkrb5-dev liblapack3gf liblcms1-dev libldap2-dev libllvm3.0 liblodo3.0
; liblog4cxx10 liblog4cxx10-dev libltdl-dev liblua5.1-0 liblua5.1-0-dev libmail-sendmail-perl
; libmng-dev libmng1 libmysqlclient-dev libmysqlclient18 libncurses5-dev libnetcdf-dev libnetcdf6
; libnettle4 libnuma1 libodbc1 libogg-dev libogg0 libogre-1.7.4 libogre-dev libois-1.3.0
; libopencv-core2.3 libopencv-highgui2.3 libopencv-imgproc2.3 libopenexr6 libopenjpeg2
; libopenmpi-dev libopenmpi1.3 libopenni-dev libopenni-sensor-primesense0 libopenni0 liborc-0.4-0
; libp11-kit-dev libpango1.0-dev libpathplan4 libpcl-1.7-all libpcl-1.7-all-dev libpcl-1.7-bin
; libpcl-1.7-doc libpcl-apps-1.7 libpcl-apps-1.7-dev libpcl-common-1.7 libpcl-common-1.7-dev
; libpcl-features-1.7 libpcl-features-1.7-dev libpcl-filters-1.7 libpcl-filters-1.7-dev
; libpcl-geometry-1.7-dev libpcl-io-1.7 libpcl-io-1.7-dev libpcl-kdtree-1.7 libpcl-kdtree-1.7-dev
; libpcl-keypoints-1.7 libpcl-keypoints-1.7-dev libpcl-octree-1.7 libpcl-octree-1.7-dev
; libpcl-outofcore-1.7 libpcl-outofcore-1.7-dev libpcl-people-1.7 libpcl-people-1.7-dev
; libpcl-recognition-1.7 libpcl-recognition-1.7-dev libpcl-registration-1.7
; libpcl-registration-1.7-dev libpcl-sample-consensus-1.7 libpcl-sample-consensus-1.7-dev
; libpcl-search-1.7 libpcl-search-1.7-dev libpcl-segmentation-1.7 libpcl-segmentation-1.7-dev
; libpcl-surface-1.7 libpcl-surface-1.7-dev libpcl-tracking-1.7 libpcl-tracking-1.7-dev
; libpcl-visualization-1.7 libpcl-visualization-1.7-dev libpcre3-dev libpcrecpp0 libphonon4
; libpixman-1-dev libplayerc++3.0 libplayerc3.0 libplayercommon3.0 libplayercore3.0
; libplayerdrivers3.0 libplayerinterface3.0 libplayerjpeg3.0 libplayertcp3.0 libplayerwkb3.0
; libpmap3.0 libpng12-dev libpoco-dev libpococrypto9 libpocodata9 libpocofoundation9 libpocomysql9
; libpoconet9 libpoconetssl9 libpocoodbc9 libpocosqlite9 libpocoutil9 libpocoxml9 libpocozip9
; libpoppler19 libpostproc52 libpq-dev libpq5 libprotobuf-dev libprotobuf-lite7 libprotobuf7
; libprotoc7 libproxy1 libpthread-stubs0 libpthread-stubs0-dev libpulse-dev libpulse-mainloop-glib0
; libpulse0 libpyside-dev libpyside-py3-1.1 libpyside1.1 libpython3.2 libqhull-dev libqhull5
; libqt4-dbus libqt4-declarative libqt4-designer libqt4-dev libqt4-help libqt4-network
; libqt4-opengl libqt4-opengl-dev libqt4-qt3support libqt4-script libqt4-scripttools libqt4-sql
; libqt4-sql-mysql libqt4-svg libqt4-test libqt4-xml libqt4-xmlpatterns libqtassistantclient4
; libqtcore4 libqtgui4 libqtwebkit-dev libqtwebkit4 libqwt-dev libqwt5-qt4 libqwt6 libraw1394-11
; libraw5 librtmp-dev libsamplerate0 libschroedinger-1.0-0 libsdl-image1.2 libsdl-image1.2-dev
; libsdl1.2-dev libsdl1.2debian libshiboken-dev libshiboken-py3-1.1 libshiboken1.1 libshout3
; libsilly libslang2-dev libsm-dev libsndfile1 libsoup-gnome2.4-1 libsoup2.4-1 libspeex1
; libsqlite3-dev libstatgrab6 libstdc++6-4.4-dev libstdc++6-4.6-dev libswscale-dev libswscale2
; libsys-hostname-long-perl libtag1-vanilla libtag1c2a libtar0 libtasn1-3-dev libtbb-dev libtbb2
; libtheora-dev libtheora0 libtiff4-dev libtiffxx0c2 libtinyxml-dev libtinyxml2.6.2 libtool
; libtorque2 libunistring0 libusb-1.0-0-dev libutempter0 libuuid-perl libv4l-0 libv4l-dev
; libv4lconvert0 libva1 libvisual-0.4-0 libvisual-0.4-plugins libvorbis0a libvorbisenc2 libvpx1
; libvtk5-dev libvtk5-qt4-dev libvtk5.8 libvtk5.8-qt4 libwavpack1 libwxbase2.8-0 libwxgtk2.8-0
; libx11-dev libx11-doc libx11-xcb1 libxau-dev libxaw7 libxaw7-dev libxcb-glx0 libxcb-render0-dev
; libxcb-shape0 libxcb-shm0-dev libxcb1-dev libxcomposite-dev libxcursor-dev libxdamage-dev
; libxdmcp-dev libxerces-c3.1 libxext-dev libxfixes-dev libxfont1 libxft-dev libxi-dev
; libxinerama-dev libxml2-dev libxml2-utils libxmlrpc-core-c3 libxmu-dev libxmu-headers libxpm-dev
; libxrandr-dev libxrender-dev libxslt1.1 libxss-dev libxss1 libxt-dev libxtst6 libxv1 libxxf86dga1
; libxxf86vm1 libyaml-0-2 libyaml-tiny-perl libzzip-0-13 libzzip-dev linux-sound-base lmodern
; luatex mesa-common-dev mpi-default-dev mysql-common openmpi-common openni-utils pgf phonon
; phonon-backend-gstreamer pkg-config po-debconf preview-latex-style prosper ps2eps python-cairo
; python-catkin-pkg python-crypto python-dateutil python-dev python-docutils python-empy
; python-epydoc python-glade2 python-gobject python-gobject-2 python-gtk2 python-imaging
; python-jinja2 python-kitchen python-lxml python-markupsafe python-matplotlib
; python-matplotlib-data python-netifaces python-nose python-numpy python-opengl python-paramiko
; python-pkg-resources python-psutil python-pydot python-pygments python-pyparsing python-pyside
; python-pyside.phonon python-pyside.qtcore python-pyside.qtdeclarative python-pyside.qtgui
; python-pyside.qthelp python-pyside.qtnetwork python-pyside.qtopengl python-pyside.qtscript
; python-pyside.qtsql python-pyside.qtsvg python-pyside.qttest python-pyside.qtuitools
; python-pyside.qtwebkit python-pyside.qtxml python-qt4 python-qt4-dev python-qt4-gl
; python-qwt5-qt4 python-roman python-rosdep python-rosdistro python-rospkg python-sip
; python-sip-dev python-sphinx python-support python-tk python-tz python-wxgtk2.8 python-wxversion
; python-yaml python2.7-dev python3 python3-minimal python3-pkg-resources python3-setuptools
; python3.2 python3.2-minimal qdbus qt4-linguist-tools qt4-qmake robot-player ros-hydro-actionlib
; ros-hydro-actionlib-msgs ros-hydro-actionlib-tutorials ros-hydro-amcl ros-hydro-angles
; ros-hydro-base-local-planner ros-hydro-bfl ros-hydro-bond ros-hydro-bond-core ros-hydro-bondcpp
; ros-hydro-bondpy ros-hydro-camera-calibration ros-hydro-camera-calibration-parsers
; ros-hydro-camera-info-manager ros-hydro-carrot-planner ros-hydro-catkin ros-hydro-class-loader
; ros-hydro-clear-costmap-recovery ros-hydro-collada-parser ros-hydro-collada-urdf
; ros-hydro-common-msgs ros-hydro-common-tutorials ros-hydro-compressed-depth-image-transport
; ros-hydro-compressed-image-transport ros-hydro-console-bridge ros-hydro-control-msgs
; ros-hydro-costmap-2d ros-hydro-cpp-common ros-hydro-cv-bridge ros-hydro-depth-image-proc
; ros-hydro-desktop ros-hydro-desktop-full ros-hydro-diagnostic-aggregator
; ros-hydro-diagnostic-analysis ros-hydro-diagnostic-common-diagnostics ros-hydro-diagnostic-msgs
; ros-hydro-diagnostic-updater ros-hydro-diagnostics ros-hydro-driver-base ros-hydro-driver-common
; ros-hydro-dwa-local-planner ros-hydro-dynamic-reconfigure ros-hydro-eigen-conversions
; ros-hydro-eigen-stl-containers ros-hydro-executive-smach ros-hydro-fake-localization
; ros-hydro-filters ros-hydro-gazebo-msgs ros-hydro-gazebo-plugins ros-hydro-gazebo-ros
; ros-hydro-gazebo-ros-pkgs ros-hydro-gencpp ros-hydro-genlisp ros-hydro-genmsg ros-hydro-genpy
; ros-hydro-geometric-shapes ros-hydro-geometry ros-hydro-geometry-experimental
; ros-hydro-geometry-msgs ros-hydro-geometry-tutorials ros-hydro-gmapping ros-hydro-image-common
; ros-hydro-image-geometry ros-hydro-image-pipeline ros-hydro-image-proc ros-hydro-image-rotate
; ros-hydro-image-transport ros-hydro-image-transport-plugins ros-hydro-image-view
; ros-hydro-interactive-marker-tutorials ros-hydro-interactive-markers
; ros-hydro-joint-state-publisher ros-hydro-kdl-conversions ros-hydro-kdl-parser
; ros-hydro-laser-assembler ros-hydro-laser-filters ros-hydro-laser-geometry
; ros-hydro-laser-pipeline ros-hydro-librviz-tutorial ros-hydro-map-msgs ros-hydro-map-server
; ros-hydro-media-export ros-hydro-message-filters ros-hydro-message-generation
; ros-hydro-message-runtime ros-hydro-mk ros-hydro-mobile ros-hydro-move-base
; ros-hydro-move-base-msgs ros-hydro-move-slow-and-clear ros-hydro-nav-core ros-hydro-nav-msgs
; ros-hydro-navfn ros-hydro-navigation ros-hydro-nodelet ros-hydro-nodelet-core
; ros-hydro-nodelet-topic-tools ros-hydro-nodelet-tutorial-math ros-hydro-octomap ros-hydro-opencv2
; ros-hydro-openslam-gmapping ros-hydro-orocos-kdl ros-hydro-pcl-conversions ros-hydro-pcl-msgs
; ros-hydro-pcl-ros ros-hydro-perception ros-hydro-perception-pcl ros-hydro-pluginlib
; ros-hydro-pluginlib-tutorials ros-hydro-polled-camera ros-hydro-python-orocos-kdl
; ros-hydro-python-qt-binding ros-hydro-qt-dotgraph ros-hydro-qt-gui ros-hydro-qt-gui-app
; ros-hydro-qt-gui-core ros-hydro-qt-gui-cpp ros-hydro-qt-gui-py-common ros-hydro-random-numbers
; ros-hydro-resource-retriever ros-hydro-robot ros-hydro-robot-model ros-hydro-robot-pose-ekf
; ros-hydro-robot-state-publisher ros-hydro-ros ros-hydro-ros-base ros-hydro-ros-comm
; ros-hydro-ros-full ros-hydro-ros-tutorials ros-hydro-rosbag ros-hydro-rosbag-migration-rule
; ros-hydro-rosbag-storage ros-hydro-rosbash ros-hydro-rosboost-cfg ros-hydro-rosbuild
; ros-hydro-rosclean ros-hydro-rosconsole ros-hydro-rosconsole-bridge ros-hydro-roscpp
; ros-hydro-roscpp-serialization ros-hydro-roscpp-traits ros-hydro-roscpp-tutorials
; ros-hydro-roscreate ros-hydro-rosdoc-lite ros-hydro-rosgraph ros-hydro-rosgraph-msgs
; ros-hydro-roslang ros-hydro-roslaunch ros-hydro-roslib ros-hydro-roslisp ros-hydro-rosmake
; ros-hydro-rosmaster ros-hydro-rosmsg ros-hydro-rosnode ros-hydro-rosout ros-hydro-rospack
; ros-hydro-rosparam ros-hydro-rospy ros-hydro-rospy-tutorials ros-hydro-rosservice
; ros-hydro-rostest ros-hydro-rostime ros-hydro-rostopic ros-hydro-rosunit ros-hydro-roswtf
; ros-hydro-rotate-recovery ros-hydro-rqt-action ros-hydro-rqt-bag ros-hydro-rqt-bag-plugins
; ros-hydro-rqt-common-plugins ros-hydro-rqt-console ros-hydro-rqt-dep ros-hydro-rqt-graph
; ros-hydro-rqt-gui ros-hydro-rqt-gui-cpp ros-hydro-rqt-gui-py ros-hydro-rqt-image-view
; ros-hydro-rqt-launch ros-hydro-rqt-logger-level ros-hydro-rqt-moveit ros-hydro-rqt-msg
; ros-hydro-rqt-nav-view ros-hydro-rqt-plot ros-hydro-rqt-pose-view ros-hydro-rqt-publisher
; ros-hydro-rqt-py-common ros-hydro-rqt-py-console ros-hydro-rqt-reconfigure
; ros-hydro-rqt-robot-dashboard ros-hydro-rqt-robot-monitor ros-hydro-rqt-robot-plugins
; ros-hydro-rqt-robot-steering ros-hydro-rqt-runtime-monitor ros-hydro-rqt-rviz
; ros-hydro-rqt-service-caller ros-hydro-rqt-shell ros-hydro-rqt-srv ros-hydro-rqt-tf-tree
; ros-hydro-rqt-top ros-hydro-rqt-topic ros-hydro-rqt-web ros-hydro-rviz
; ros-hydro-rviz-plugin-tutorials ros-hydro-rviz-python-tutorial ros-hydro-self-test
; ros-hydro-sensor-msgs ros-hydro-shape-msgs ros-hydro-shape-tools ros-hydro-simulators
; ros-hydro-smach ros-hydro-smach-msgs ros-hydro-smach-ros ros-hydro-smclib ros-hydro-stage
; ros-hydro-stage-ros ros-hydro-std-msgs ros-hydro-std-srvs ros-hydro-stereo-image-proc
; ros-hydro-stereo-msgs ros-hydro-tf ros-hydro-tf-conversions ros-hydro-tf2 ros-hydro-tf2-bullet
; ros-hydro-tf2-geometry-msgs ros-hydro-tf2-kdl ros-hydro-tf2-msgs ros-hydro-tf2-py
; ros-hydro-tf2-ros ros-hydro-tf2-tools ros-hydro-theora-image-transport ros-hydro-timestamp-tools
; ros-hydro-topic-tools ros-hydro-trajectory-msgs ros-hydro-turtle-actionlib ros-hydro-turtle-tf
; ros-hydro-turtlesim ros-hydro-urdf ros-hydro-urdf-parser-plugin ros-hydro-urdf-tutorial
; ros-hydro-urdfdom ros-hydro-urdfdom-headers ros-hydro-vision-opencv
; ros-hydro-visualization-marker-tutorials ros-hydro-visualization-msgs
; ros-hydro-visualization-tutorials ros-hydro-viz ros-hydro-voxel-grid ros-hydro-xacro
; ros-hydro-xmlrpcpp sdformat shiboken sphinx-common sphinx-doc tango-icon-theme tcl8.5 tcl8.5-dev
; tex-common texlive-base texlive-binaries texlive-common texlive-doc-base texlive-extra-utils
; texlive-font-utils texlive-fonts-recommended texlive-fonts-recommended-doc
; texlive-generic-recommended texlive-latex-base texlive-latex-base-doc texlive-latex-extra
; texlive-latex-extra-doc texlive-latex-recommended texlive-latex-recommended-doc texlive-luatex
; texlive-pictures texlive-pictures-doc texlive-pstricks texlive-pstricks-doc tipa tk8.5 tk8.5-dev
; ttf-liberation ttf-lyx uuid-dev x11-utils x11proto-composite-dev x11proto-core-dev
; x11proto-damage-dev x11proto-fixes-dev x11proto-input-dev x11proto-kb-dev x11proto-randr-dev
; x11proto-render-dev x11proto-scrnsaver-dev x11proto-xext-dev x11proto-xinerama-dev xbitmaps
; xfonts-encodings xfonts-utils xorg-sgml-doctools xterm xtrans-dev yaml-cpp
;The following packages will be upgraded:
; libavahi-client3 libavahi-common3 libcurl3 libdbus-1-3 libdrm-intel1 libdrm-nouveau1a
; libdrm-radeon1 libdrm2 libexpat1 libfreetype6 libgcrypt11 libglib2.0-0 libgnutls26
; libgssapi-krb5-2 libjpeg-turbo8 libk5crypto3 libkrb5-3 libkrb5support0 libldap-2.4-2
; libpixman-1-0 libsqlite3-0 libtasn1-3 libx11-6 libxcb1 libxext6 libxfixes3 libxi6 libxml2 python
; python-gi python-minimal
;-------------------------
;3versions of the roslisp client, 
;
;/home/vagrant/dwn/lang/lsp/code/project/src/roslisp
;/opt/ros/hydro/share/roslisp
;/home/vagrant/dwn/lang/lsp/code/project/src/ros_comm/clients/roslisp
;
;all w/the same ros_comm error:   System "rosgraph_msgs-msg" not found
;http://www.ros.org/browse/list.php has several incl:
;http://wiki.ros.org/cl_semantic_map_utils http://wiki.ros.org/actionlib_lisp 
;git_ https://github.com/cram-code/cram_physics.git
;git_ https://github.com/cram-code/cram_highlevel.git
;git_ https://github.com/moesenle/cram_core.git
;git_ http://code.in.tum.de/git/roll.git
;git_ https://github.com/ros/genlisp.git
;git_ https://code.ros.org/svn/ros-pkg/stacks/roslisp_common/trunk
;has:
;cram_core/cram-execution-trace.asd
;cram_core/cram-language.asd
;cram_core/cram-language-tests.asd
;cram_core/cram-math.asd
;cram_core/cram-math-test.asd
;cram_core/cram-projection.asd
;cram_core/cram-projection-tests.asd
;cram_core/cram-reasoning.asd
;cram_core/cram-reasoning-tests.asd
;cram_core/cram-test-utilities.asd
;cram_core/cram-test-utilities-tests.asd
;cram_core/cram-utilities.asd
;cram_core/cram-utilities-tests.asd
;cram_core/designators.asd
;cram_core/designators-test.asd
;cram_core/process-modules.asd
;cram_core/process-modules-test.asd
;         synchronization-tools.asd
;roll/cl-libsvm.asd
;roll/roll.asd
;
;add: -repl & -utilities:
;ros-hydro-roslisp - Lisp client library for ROS, the Robot Operating System.
;ros-hydro-roslisp-common - Common libraries to control ROS based robots. This stack contains an implementation of actionlib (client and server) in Common Lisp, a transformation library and an implementation of tf in Common Lisp.
;ros-hydro-roslisp-repl - This package provides a script that launches Emacs with Slime (the Superior Lisp Interaction Mode) ready for Lisp development and roslisp.
;ros-hydro-roslisp-utilities - Some utility functionality to interact with ROS using roslisp. 
;
;outside the vagrant/in osx, git got:
;λ▶<140 m2local: /src/lsp> ls
;bullet-reasoning-demo.asd@              cram_highlevel/
;bullet-reasoning-designators.asd@       cram_physics/
;bullet-reasoning-test.asd@              designators-ros.asd@
;bullet-reasoning.asd@                   designators-test.asd@
;cffi-ros-utils.asd@                     designators.asd@
;cl-bullet-examples.asd@                 doc/
;cl-bullet-vis-examples.asd@             execution-trace-server.asd@
;cl-bullet-vis-tests.asd@                fake-process-modules.asd@
;cl-bullet-vis.asd@                      genlisp/
;cl-bullet.asd@                          get
;cl-glx.asd@                             get~
;cl-libsvm.asd@                          git1
;cl-semantic-map-utils.asd@              la
;cl-urdf.asd@                            la~
;cram-environment-representation.asd@    location-costmap-test.asd@
;cram-execution-trace.asd@               location-costmap.asd@
;cram-language-tests.asd@                location-designator-projection.asd@
;cram-language.asd@                      map-annotation.asd@
;cram-manipulation-knowledge.asd@        object-location-designators.asd@
;cram-math-test.asd@                     occupancy-grid-costmap.asd@
;cram-math.asd@                          perception-process-module.asd@
;cram-plan-actionserver.asd@             physics-utils.asd@
;cram-plan-failures.asd@                 process-modules-test.asd@
;cram-plan-knowledge.asd@                process-modules.asd@
;cram-plan-library.asd@                  projection-process-modules.asd@
;cram-plan-transformations.asd@          robot-mask.asd@
;cram-pr2-knowledge.asd@                 roll/
;cram-projection-tests.asd@              roll.asd@
;cram-projection.asd@                    roslisp_runtime - ROS Wiki.html
;cram-reasoning-tests.asd@               roslisp_support - ROS Wiki.html
;cram-reasoning.asd@                     semantic-map-cache.asd@
;cram-roslisp-common.asd@                semantic-map-collision-environment.asd@
;cram-test-utilities-tests.asd@          semantic-map-costmap.asd@
;cram-test-utilities.asd@                spatial-relations-costmap.asd@
;cram-utilities-tests.asd@               synchronization-tools/
;cram-utilities.asd@                     synchronization-tools.asd@
;cram_core/                              visibility-costmap.asd@
;
;roslisp_common/
;actionlib_lisp/  cl_tf/  cl_transforms/  cl_utils/  roslisp_common/  roslisp_utilities/
;
;home server now has:  (running 13.10, so had to ftp over from 12... install)
;/roslisp/ros> ls
;actionlib.asd@                navfn-srv.asd@             rospy_tutorials-srv.asd@
;actionlib_lisp/               nav_msgs-msg.asd@          sensor_msgs-msg.asd@
;actionlib-msg.asd@            nav_msgs-srv.asd@          sensor_msgs-srv.asd@
;actionlib_msgs-msg.asd@       nodelet-srv.asd@           shape_msgs-msg.asd@
;actionlib_tutorials-msg.asd@  note                       smach_msgs-msg.asd@
;base_local_planner-msg.asd@   pcl_msgs-msg.asd@          std_msgs-msg.asd@
;bond-msg.asd@                 polled_camera-srv.asd@     std_srvs-srv.asd@
;common-lisp/                  robot_pose_ekf-srv.asd@    stereo_msgs-msg.asd@
;control_msgs-msg.asd@         roscpp-msg.asd@            s-xml.asd@
;control_msgs-srv.asd@         roscpp-srv.asd@            s-xml-rpc.asd@
;costmap_2d-msg.asd@           roscpp_tutorials-srv.asd@  tf2_msgs-msg.asd@
;diagnostic_msgs-msg.asd@      rosgraph_msgs-msg.asd@     tf2_msgs-srv.asd@
;diagnostic_msgs-srv.asd@      roslisp/                   tf-msg.asd@
;driver_base-msg.asd@          roslisp.asd@               tf-srv.asd@
;dynamic_reconfigure-msg.asd@  roslisp_common/            theora_image_transport-msg.asd@
;dynamic_reconfigure-srv.asd@  roslisp-msg-protocol.asd@  topic_tools-srv.asd@
;gazebo_msgs-msg.asd@          roslisp_repl/              trajectory_msgs-msg.asd@
;gazebo_msgs-srv.asd@          roslisp_utilities/         turtle_actionlib-msg.asd@
;geometry_msgs-msg.asd@        roslisp-utilities.asd@     turtlesim-msg.asd@
;map_msgs-msg.asd@             roslisp-utils.asd@         turtlesim-srv.asd@
;map_msgs-srv.asd@             ros-load-manifest.asd@     visualization_msgs-msg.asd@
;move_base_msgs-msg.asd@       rospy_tutorials-msg.asd@   z/
;
;ros-indigo-roslisp - Lisp client library for ROS, the Robot Operating System. ;new apr2014
;http://fei.edu.br/~murilo/rosfei/2014/ROS_Day1_Intro_handout.pdf 
;intersting communication model, might be useable beyond some 'robotics' work
;
;tie in w/r.cl http://journal.r-project.org/archive/2013-2/dietrich-zug-kaiser.pdf
; svn co http://svn.code.sf.net/p/ivs-ros-pkg/code/trunk/rosR_demos
;
;-web-srvc:
;http://www.rosbridge.org/doku.php json msg  ;also: py.cl cl-xmpp
; also just installed: ros-indigo-xmlrpcpp 
;
; http://wiki.ros.org/rosbridge_server 
; https://www.google.com/search?q=lisp+websocket&oq=lisp+websocket
;
; http://wiki.ros.org/rosbridge_suiterosbridge protocol is a specification for sending JSON based commands to ROS (and in theory, any other robot middleware). An example of the protocol for subscribing to a topic:
; { "op": "subscribe",
;   "topic": "/cmd_vel",
;   "type": "geometry_msgs/Twist" }
;;have sparql qry/minip via json-ld also interesting
;/opt/ros> du5  ;have turtle demo going, &some of the lisp going, but roslisp tutorials not/yet
;http://wiki.ros.org/roslisp/Tutorials/BasicUsage  I have ~1/2doz version,main ones w/side lib probs
;23M     ./hydro/lib/python2.7/dist-packages
;23M     ./hydro/lib/python2.7
;85M     ./hydro/lib
;17M     ./hydro/include
;20M     ./hydro/share/OpenCV/haarcascades
;20M     ./hydro/share/OpenCV
;44M     ./hydro/share
;147M    ./hydro
;12M     ./indigo/lib/python2.7/dist-packages/ecto
;35M     ./indigo/lib/python2.7/dist-packages/ecto_ros
;74M     ./indigo/lib/python2.7/dist-packages
;74M     ./indigo/lib/python2.7
;162M    ./indigo/lib
;14M     ./indigo/include
;13M     ./indigo/share/moveit_resources/test/urdf/meshes/gripper_v0
;47M     ./indigo/share/moveit_resources/test/urdf/meshes
;48M     ./indigo/share/moveit_resources/test/urdf
;48M     ./indigo/share/moveit_resources/test
;48M     ./indigo/share/moveit_resources
;65M     ./indigo/share
;241M    ./indigo
;388M    .  
;on mac
;λ▶<112 m31local: /ros/indigo> ls 
;_setup_util.py* env.sh*         include/        setup.bash      setup.zsh
;bin/            etc/            lib/            setup.sh        share/
;λ▶<113 m31local: /ros/indigo> ls bin
;catkin_find*              roscore*                  rosparam*
;catkin_init_workspace*    roscreate-pkg*            rosrun*
;catkin_make*              rosgraph*                 rosservice*
;catkin_make_isolated*     roslaunch*                rossrv*
;catkin_package_version*   roslaunch-complete*       rosstack*
;catkin_prepare_release*   roslaunch-deps*           rostest*
;catkin_test_results*      roslaunch-logs*           rostopic*
;catkin_topological_order* rosmake*                  rosunit*
;check_urdf*               rosmaster*                roswtf*
;plugin_macro_update*      rosmsg*                   tf_remap*
;rosbag*                   rosmsg-proto*             urdf_mem_test*
;rosboost-cfg*             rosnode*                  urdf_to_graphiz*
;rosclean*                 rospack*                  view_frames* 
;λ▶<121 m31local: /opt/ros> du5
; 16M    ./hydro/include
; 22M    ./hydro/lib/python2.7/dist-packages
; 22M    ./hydro/lib/python2.7
; 83M    ./hydro/lib
; 19M    ./hydro/share/OpenCV/haarcascades
; 19M    ./hydro/share/OpenCV
; 40M    ./hydro/share
;141M    ./hydro
; 12M    ./indigo/lib/python2.7/dist-packages/ecto
; 35M    ./indigo/lib/python2.7/dist-packages/ecto_ros
; 62M    ./indigo/lib/python2.7/dist-packages
; 62M    ./indigo/lib/python2.7
;111M    ./indigo/lib
; 11M    ./indigo/share
;130M    ./indigo
;271M    . 
; /roslisp/ros> count *.asd ;       64      64    1338
; /robot/ros> count *.asd ;      169     169    3847
