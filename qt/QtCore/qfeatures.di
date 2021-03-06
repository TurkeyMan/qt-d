module qt.QtCore.qfeatures;

/*
 * All feature dependencies.
 *
 * This list is generated by qmake from <qtbase>/src/corelib/global/qfeatures.txt
 */
version(QT_NO_PROPERTIES)
    version = QT_NO_DBUS;
version(QT_NO_XMLSTREAMREADER)
    version = QT_NO_DBUS;
version(QT_NO_PROPERTIES)
    version = QT_NO_ACCESSIBILITY;
version(QT_NO_MENUBAR)
    version = QT_NO_ACCESSIBILITY;
version(QT_NO_UNDOSTACK)
    version = QT_NO_UNDOVIEW;
version(QT_NO_LISTVIEW)
    version = QT_NO_UNDOVIEW;
version(QT_NO_UNDOCOMMAND)
    version = QT_NO_UNDOSTACK;
version(QT_NO_UNDOSTACK)
    version = QT_NO_UNDOGROUP;
version(QT_NO_FILESYSTEMMODEL)
    version = QT_NO_FSCOMPLETER;
version(QT_NO_COMPLETER)
    version = QT_NO_FSCOMPLETER;
version(QT_NO_LIBRARY)
    version = QT_NO_BEARERMANAGEMENT;
version(QT_NO_NETWORKINTERFACE)
    version = QT_NO_BEARERMANAGEMENT;
version(QT_NO_PROPERTIES)
    version = QT_NO_BEARERMANAGEMENT;
version(QT_NO_NETWORKPROXY)
    version = QT_NO_SOCKS5;
version(QT_NO_TEXTCODEC)
    version = QT_NO_ICONV;
version(QT_NO_TEXTCODEC)
    version = QT_NO_BIG_CODECS;
version(QT_NO_TEXTCODEC)
    version = QT_NO_CODECS;
version(QT_NO_PRINTER)
    version = QT_NO_CUPS;
version(QT_NO_LIBRARY)
    version = QT_NO_CUPS;
version(QT_NO_PICTURE)
    version = QT_NO_PRINTER;
version(QT_NO_TEMPORARYFILE)
    version = QT_NO_PRINTER;
version(QT_NO_PDF)
    version = QT_NO_PRINTER;
version(QT_NO_STYLE_WINDOWS)
    version = QT_NO_STYLE_STYLESHEET;
version(QT_NO_PROPERTIES)
    version = QT_NO_STYLE_STYLESHEET;
version(QT_NO_CSSPARSER)
    version = QT_NO_STYLE_STYLESHEET;
version(QT_NO_STYLE_WINDOWS)
    version = QT_NO_STYLE_WINDOWSMOBILE;
version(QT_NO_IMAGEFORMAT_XPM)
    version = QT_NO_STYLE_WINDOWSMOBILE;
version(QT_NO_STYLE_WINDOWS)
    version = QT_NO_STYLE_WINDOWSCE;
version(QT_NO_IMAGEFORMAT_XPM)
    version = QT_NO_STYLE_WINDOWSCE;
version(QT_NO_STYLE_WINDOWS)
    version = QT_NO_STYLE_WINDOWSXP;
version(QT_NO_STYLE_WINDOWSXP)
    version = QT_NO_STYLE_WINDOWSVISTA;
version(QT_NO_ITEMVIEWS)
    version = QT_NO_DATAWIDGETMAPPER;
version(QT_NO_PROPERTIES)
    version = QT_NO_DATAWIDGETMAPPER;
version(QT_NO_ITEMVIEWS)
    version = QT_NO_DIRMODEL;
version(QT_NO_FILESYSTEMMODEL)
    version = QT_NO_DIRMODEL;
version(QT_NO_COMBOBOX)
    version = QT_NO_INPUTDIALOG;
version(QT_NO_SPINBOX)
    version = QT_NO_INPUTDIALOG;
version(QT_NO_STACKEDWIDGET)
    version = QT_NO_INPUTDIALOG;
version(QT_NO_PRINTPREVIEWWIDGET)
    version = QT_NO_PRINTPREVIEWDIALOG;
version(QT_NO_PRINTDIALOG)
    version = QT_NO_PRINTPREVIEWDIALOG;
version(QT_NO_TOOLBAR)
    version = QT_NO_PRINTPREVIEWDIALOG;
version(QT_NO_PRINTER)
    version = QT_NO_PRINTDIALOG;
version(QT_NO_COMBOBOX)
    version = QT_NO_PRINTDIALOG;
version(QT_NO_BUTTONGROUP)
    version = QT_NO_PRINTDIALOG;
version(QT_NO_SPINBOX)
    version = QT_NO_PRINTDIALOG;
version(QT_NO_TREEVIEW)
    version = QT_NO_PRINTDIALOG;
version(QT_NO_TABWIDGET)
    version = QT_NO_PRINTDIALOG;
version(QT_NO_STRINGLISTMODEL)
    version = QT_NO_FONTDIALOG;
version(QT_NO_COMBOBOX)
    version = QT_NO_FONTDIALOG;
version(QT_NO_VALIDATOR)
    version = QT_NO_FONTDIALOG;
version(QT_NO_GROUPBOX)
    version = QT_NO_FONTDIALOG;
version(QT_NO_DIRMODEL)
    version = QT_NO_FILEDIALOG;
version(QT_NO_TREEVIEW)
    version = QT_NO_FILEDIALOG;
version(QT_NO_COMBOBOX)
    version = QT_NO_FILEDIALOG;
version(QT_NO_TOOLBUTTON)
    version = QT_NO_FILEDIALOG;
version(QT_NO_BUTTONGROUP)
    version = QT_NO_FILEDIALOG;
version(QT_NO_TOOLTIP)
    version = QT_NO_FILEDIALOG;
version(QT_NO_SPLITTER)
    version = QT_NO_FILEDIALOG;
version(QT_NO_STACKEDWIDGET)
    version = QT_NO_FILEDIALOG;
version(QT_NO_PROXYMODEL)
    version = QT_NO_FILEDIALOG;
version(QT_NO_LINEEDIT)
    version = QT_NO_KEYSEQUENCEEDIT;
version(QT_NO_SHORTCUT)
    version = QT_NO_KEYSEQUENCEEDIT;
version(QT_NO_GRAPHICSVIEW)
    version = QT_NO_PRINTPREVIEWWIDGET;
version(QT_NO_PRINTER)
    version = QT_NO_PRINTPREVIEWWIDGET;
version(QT_NO_MAINWINDOW)
    version = QT_NO_PRINTPREVIEWWIDGET;
version(QT_NO_TABLEVIEW)
    version = QT_NO_CALENDARWIDGET;
version(QT_NO_MENU)
    version = QT_NO_CALENDARWIDGET;
version(QT_NO_TEXTDATE)
    version = QT_NO_CALENDARWIDGET;
version(QT_NO_SPINBOX)
    version = QT_NO_CALENDARWIDGET;
version = QT_NO_CALENDARWIDGET;
    version = QT_NO_CALENDARWIDGET;
version(QT_NO_TOOLBUTTON)
    version = QT_NO_CALENDARWIDGET;
version(QT_NO_PROGRESSBAR)
    version = QT_NO_PROGRESSDIALOG;
version(QT_NO_MENU)
    version = QT_NO_MENUBAR;
version(QT_NO_TOOLBUTTON)
    version = QT_NO_MENUBAR;
version(QT_NO_SLIDER)
    version = QT_NO_DIAL;
version(QT_NO_SLIDER)
    version = QT_NO_SCROLLBAR;
version(QT_NO_SCROLLBAR)
    version = QT_NO_SCROLLAREA;
version(QT_NO_SCROLLAREA)
    version = QT_NO_GRAPHICSVIEW;
version(QT_NO_GRAPHICSVIEW)
    version = QT_NO_GRAPHICSEFFECT;
version(QT_NO_SCROLLAREA)
    version = QT_NO_MDIAREA;
version(QT_NO_RUBBERBAND)
    version = QT_NO_DOCKWIDGET;
version(QT_NO_MAINWINDOW)
    version = QT_NO_DOCKWIDGET;
version(QT_NO_GROUPBOX)
    version = QT_NO_BUTTONGROUP;
version(QT_NO_TOOLBUTTON)
    version = QT_NO_TOOLBOX;
version(QT_NO_SCROLLAREA)
    version = QT_NO_TOOLBOX;
version(QT_NO_MENU)
    version = QT_NO_MAINWINDOW;
version(QT_NO_RESIZEHANDLER)
    version = QT_NO_MAINWINDOW;
version(QT_NO_TOOLBUTTON)
    version = QT_NO_MAINWINDOW;
version(QT_NO_MAINWINDOW)
    version = QT_NO_TOOLBAR;
version(QT_NO_COMBOBOX)
    version = QT_NO_FONTCOMBOBOX;
version(QT_NO_STRINGLISTMODEL)
    version = QT_NO_FONTCOMBOBOX;
version(QT_NO_LINEEDIT)
    version = QT_NO_COMBOBOX;
version(QT_NO_STANDARDITEMMODEL)
    version = QT_NO_COMBOBOX;
version(QT_NO_LISTVIEW)
    version = QT_NO_COMBOBOX;
version(QT_NO_TABBAR)
    version = QT_NO_TABWIDGET;
version(QT_NO_STACKEDWIDGET)
    version = QT_NO_TABWIDGET;
version(QT_NO_SPINWIDGET)
    version = QT_NO_SPINBOX;
version(QT_NO_LINEEDIT)
    version = QT_NO_SPINBOX;
version(QT_NO_VALIDATOR)
    version = QT_NO_SPINBOX;
version(QT_NO_SPINBOX)
    version = QT_NO_COLORDIALOG;
version(QT_NO_RUBBERBAND)
    version = QT_NO_SPLITTER;
version(QT_NO_SCROLLAREA)
    version = QT_NO_TEXTEDIT;
version(QT_NO_PROPERTIES)
    version = QT_NO_TEXTEDIT;
version(QT_NO_TEXTEDIT)
    version = QT_NO_ERRORMESSAGE;
version(QT_NO_TEXTEDIT)
    version = QT_NO_SYNTAXHIGHLIGHTER;
version(QT_NO_TEXTEDIT)
    version = QT_NO_TEXTBROWSER;
version(QT_NO_CALENDARWIDGET)
    version = QT_NO_DATETIMEEDIT;
version(QT_NO_DATESTRING)
    version = QT_NO_DATETIMEEDIT;
version(QT_NO_RUBBERBAND)
    version = QT_NO_ITEMVIEWS;
version(QT_NO_SCROLLAREA)
    version = QT_NO_ITEMVIEWS;
version(QT_NO_ITEMVIEWS)
    version = QT_NO_STRINGLISTMODEL;
version(QT_NO_ITEMVIEWS)
    version = QT_NO_PROXYMODEL;
version(QT_NO_PROXYMODEL)
    version = QT_NO_COMPLETER;
version(QT_NO_PROXYMODEL)
    version = QT_NO_IDENTITYPROXYMODEL;
version(QT_NO_PROXYMODEL)
    version = QT_NO_SORTFILTERPROXYMODEL;
version(QT_NO_ITEMVIEWS)
    version = QT_NO_STANDARDITEMMODEL;
version(QT_NO_ITEMVIEWS)
    version = QT_NO_TABLEVIEW;
version(QT_NO_TABLEVIEW)
    version = QT_NO_TABLEWIDGET;
version(QT_NO_ITEMVIEWS)
    version = QT_NO_LISTVIEW;
version(QT_NO_LISTVIEW)
    version = QT_NO_COLUMNVIEW;
version(QT_NO_LISTVIEW)
    version = QT_NO_LISTWIDGET;
version(QT_NO_ITEMVIEWS)
    version = QT_NO_TREEVIEW;
version(QT_NO_TREEVIEW)
    version = QT_NO_TREEWIDGET;
version(QT_NO_TEMPORARYFILE)
    version = QT_NO_LOCALSERVER;
version(QT_NO_TEMPORARYFILE)
    version = QT_NO_NETWORKDISKCACHE;
version(QT_NO_TEMPORARYFILE)
    version = QT_NO_PDF;
version(QT_NO_TEXTDATE)
    version = QT_NO_FTP;
version(QT_NO_TEXTDATE)
    version = QT_NO_DATESTRING;
version(QT_NO_LIBRARY)
    version = QT_NO_IMAGEFORMATPLUGIN;
version(QT_NO_LIBRARY)
    version = QT_NO_IM;
version(QT_NO_ACTION)
    version = QT_NO_TOOLBUTTON;
version(QT_NO_TOOLBUTTON)
    version = QT_NO_WHATSTHIS;
version(QT_NO_TOOLBUTTON)
    version = QT_NO_TABBAR;
version(QT_NO_ACTION)
    version = QT_NO_MENU;
version(QT_NO_MENU)
    version = QT_NO_CONTEXTMENU;
version(QT_NO_IMAGEFORMAT_XPM)
    version = QT_NO_STYLE_FUSION;
version(QT_NO_IMAGEFORMAT_XPM)
    version = QT_NO_DRAGANDDROP;
version(QT_NO_XMLSTREAM)
    version = QT_NO_XMLSTREAMREADER;
version(QT_NO_XMLSTREAM)
    version = QT_NO_XMLSTREAMWRITER;
version(QT_NO_XMLSTREAMWRITER)
    version = QT_NO_TEXTODFWRITER;
version(QT_NO_PROPERTIES)
    version = QT_NO_STATEMACHINE;
version(QT_NO_PROPERTIES)
    version = QT_NO_ANIMATION;
version(QT_NO_PROPERTIES)
    version = QT_NO_WIZARD;
