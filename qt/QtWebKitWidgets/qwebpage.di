/*
    Copyright (C) 2008 Nokia Corporation and/or its subsidiary(-ies)
    Copyright (C) 2007 Staikos Computing Services Inc.

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Library General Public
    License as published by the Free Software Foundation; either
    version 2 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Library General Public License for more details.

    You should have received a copy of the GNU Library General Public License
    along with this library; see the file COPYING.LIB.  If not, write to
    the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
    Boston, MA 02110-1301, USA.
*/

#ifndef QWEBPAGE_H
#define QWEBPAGE_H

public import qt.QtWebKit.qwebkitglobal;
public import qt.QtWebKit.qwebsettings;

public import qt.QtCore.qobject;
public import qt.QtCore.qurl;
public import qt.QtWidgets.qwidget;

QT_BEGIN_NAMESPACE
class QNetworkProxy;
class QUndoStack;
class QMenu;
class QNetworkRequest;
class QNetworkReply;
class QNetworkAccessManager;
class QScreen;
QT_END_NAMESPACE

class QWebElement;
class QWebFrame;
class QWebNetworkRequest;
class QWebHistory;

class QWebFrameData;
class QWebHistoryItem;
class QWebHitTestResult;
class QWebNetworkInterface;
class QWebPageAdapter;
class QWebPagePrivate;
class QWebPluginFactory;
class QWebSecurityOrigin;
class QtViewportAttributesPrivate;

namespace WebCore {
    class ChromeClientQt;
    class EditorClientQt;
    class FrameLoaderClientQt;
    class InspectorClientQt;
    class InspectorServerRequestHandlerQt;
    class InspectorFrontendClientQt;
    class ResourceHandle;
    class QNetworkReplyHandler;

    struct FrameLoadRequest;
}

class QWEBKITWIDGETS_EXPORT QWebPage : public QObject {
    mixin Q_OBJECT;

    mixin Q_PROPERTY!(bool, "modified", "READ", "isModified");
    mixin Q_PROPERTY!(QString, "selectedText", "READ", "selectedText");
    mixin Q_PROPERTY!(QString, "selectedHtml", "READ", "selectedHtml");
    mixin Q_PROPERTY!(bool, "hasSelection", "READ", "hasSelection");
    mixin Q_PROPERTY!(QSize, "viewportSize", "READ", "viewportSize", "WRITE", "setViewportSize");
    mixin Q_PROPERTY!(QSize, "preferredContentsSize", "READ", "preferredContentsSize", "WRITE", "setPreferredContentsSize");
    mixin Q_PROPERTY!(bool, "forwardUnsupportedContent", "READ", "forwardUnsupportedContent", "WRITE", "setForwardUnsupportedContent");
    mixin Q_PROPERTY!(LinkDelegationPolicy, "linkDelegationPolicy", "READ", "linkDelegationPolicy", "WRITE", "setLinkDelegationPolicy");
    mixin Q_PROPERTY!(QPalette, "palette", "READ", "palette", "WRITE", "setPalette");
    mixin Q_PROPERTY!(bool, "contentEditable", "READ", "isContentEditable", "WRITE", "setContentEditable");
    mixin Q_PROPERTY!(VisibilityState, "visibilityState", "READ", "visibilityState", "WRITE", "setVisibilityState");
    Q_ENUMS(LinkDelegationPolicy NavigationType VisibilityState WebAction)
public:
    enum NavigationType {
        NavigationTypeLinkClicked,
        NavigationTypeFormSubmitted,
        NavigationTypeBackOrForward,
        NavigationTypeReload,
        NavigationTypeFormResubmitted,
        NavigationTypeOther
    };

    enum WebAction {
        NoWebAction = - 1,

        OpenLink,

        OpenLinkInNewWindow,
        OpenFrameInNewWindow,

        DownloadLinkToDisk,
        CopyLinkToClipboard,

        OpenImageInNewWindow,
        DownloadImageToDisk,
        CopyImageToClipboard,

        Back,
        Forward,
        Stop,
        Reload,

        Cut,
        Copy,
        Paste,

        Undo,
        Redo,
        MoveToNextChar,
        MoveToPreviousChar,
        MoveToNextWord,
        MoveToPreviousWord,
        MoveToNextLine,
        MoveToPreviousLine,
        MoveToStartOfLine,
        MoveToEndOfLine,
        MoveToStartOfBlock,
        MoveToEndOfBlock,
        MoveToStartOfDocument,
        MoveToEndOfDocument,
        SelectNextChar,
        SelectPreviousChar,
        SelectNextWord,
        SelectPreviousWord,
        SelectNextLine,
        SelectPreviousLine,
        SelectStartOfLine,
        SelectEndOfLine,
        SelectStartOfBlock,
        SelectEndOfBlock,
        SelectStartOfDocument,
        SelectEndOfDocument,
        DeleteStartOfWord,
        DeleteEndOfWord,

        SetTextDirectionDefault,
        SetTextDirectionLeftToRight,
        SetTextDirectionRightToLeft,

        ToggleBold,
        ToggleItalic,
        ToggleUnderline,

        InspectElement,

        InsertParagraphSeparator,
        InsertLineSeparator,

        SelectAll,
        ReloadAndBypassCache,

        PasteAndMatchStyle,
        RemoveFormat,

        ToggleStrikethrough,
        ToggleSubscript,
        ToggleSuperscript,
        InsertUnorderedList,
        InsertOrderedList,
        Indent,
        Outdent,

        AlignCenter,
        AlignJustified,
        AlignLeft,
        AlignRight,

        StopScheduledPageRefresh,

        CopyImageUrlToClipboard,

        OpenLinkInThisWindow,

        DownloadMediaToDisk,
        CopyMediaUrlToClipboard,
        ToggleMediaControls,
        ToggleMediaLoop,
        ToggleMediaPlayPause,
        ToggleMediaMute,
        ToggleVideoFullscreen,

        WebActionCount
    };

    enum FindFlag {
        FindBackward = 1,
        FindCaseSensitively = 2,
        FindWrapsAroundDocument = 4,
        HighlightAllOccurrences = 8,
        FindAtWordBeginningsOnly = 16,
        TreatMedialCapitalAsWordBeginning = 32,
        FindBeginsInSelection = 64
    };
    Q_DECLARE_FLAGS(FindFlags, FindFlag)

    enum LinkDelegationPolicy {
        DontDelegateLinks,
        DelegateExternalLinks,
        DelegateAllLinks
    };

    enum WebWindowType {
        WebBrowserWindow,
        WebModalDialog
    };

    enum PermissionPolicy {
        PermissionUnknown,
        PermissionGrantedByUser,
        PermissionDeniedByUser
    };

    enum Feature {
        Notifications,
        Geolocation
    };

    enum VisibilityState {
        VisibilityStateVisible,
        VisibilityStateHidden,
        VisibilityStatePrerender,
        VisibilityStateUnloaded
    };

    class QWEBKITWIDGETS_EXPORT ViewportAttributes {
    public:
        ViewportAttributes();
        ViewportAttributes(ref const(QWebPage::ViewportAttributes) other);

        ~ViewportAttributes();

        QWebPage::ViewportAttributes& operator=(ref const(QWebPage::ViewportAttributes) other);

        /+inline+/ qreal initialScaleFactor() const { return m_initialScaleFactor; }
        /+inline+/ qreal minimumScaleFactor() const { return m_minimumScaleFactor; }
        /+inline+/ qreal maximumScaleFactor() const { return m_maximumScaleFactor; }
        /+inline+/ qreal devicePixelRatio() const { return m_devicePixelRatio; }
        /+inline+/ bool isUserScalable() const { return m_isUserScalable; }
        /+inline+/ bool isValid() const { return m_isValid; }
        /+inline+/ QSizeF size() const { return m_size; }

    private:
        QSharedDataPointer<QtViewportAttributesPrivate> d;
        qreal m_initialScaleFactor;
        qreal m_minimumScaleFactor;
        qreal m_maximumScaleFactor;
        qreal m_devicePixelRatio;
        bool m_isUserScalable;
        bool m_isValid;
        QSizeF m_size;

        friend class WebCore::ChromeClientQt;
        friend class QWebPage;
    };


    explicit QWebPage(QObject *parent = 0);
    ~QWebPage();

    QWebFrame *mainFrame() const;
    QWebFrame *currentFrame() const;
    QWebFrame* frameAt(ref const(QPoint) pos) const;

    QWebHistory *history() const;
    QWebSettings *settings() const;

    void setView(QWidget *view);
    QWidget *view() const;

    bool isModified() const;
#ifndef QT_NO_UNDOSTACK
    QUndoStack *undoStack() const;
#endif

    void setNetworkAccessManager(QNetworkAccessManager *manager);
    QNetworkAccessManager *networkAccessManager() const;

    void setPluginFactory(QWebPluginFactory *factory);
    QWebPluginFactory *pluginFactory() const;

    quint64 totalBytes() const;
    quint64 bytesReceived() const;

    VisibilityState visibilityState() const;
    void setVisibilityState(VisibilityState);

    bool hasSelection() const;
    QString selectedText() const;
    QString selectedHtml() const;

#ifndef QT_NO_ACTION
    QAction *action(WebAction action) const;
#endif
    /+virtual+/ void triggerAction(WebAction action, bool checked = false);

    QSize viewportSize() const;
    void setViewportSize(ref const(QSize) size) const;
    ViewportAttributes viewportAttributesForSize(ref const(QSize) availableSize) const;

    QSize preferredContentsSize() const;
    void setPreferredContentsSize(ref const(QSize) size) const;
    void setActualVisibleContentRect(ref const(QRect) rect) const;

    /+virtual+/ bool event(QEvent*);
    bool focusNextPrevChild(bool next);

    QVariant inputMethodQuery(Qt.InputMethodQuery property) const;

    bool findText(ref const(QString) subString, FindFlags options = 0);

    void setForwardUnsupportedContent(bool forward);
    bool forwardUnsupportedContent() const;

    void setLinkDelegationPolicy(LinkDelegationPolicy policy);
    LinkDelegationPolicy linkDelegationPolicy() const;

    void setPalette(ref const(QPalette) palette);
    QPalette palette() const;

    void setContentEditable(bool editable);
    bool isContentEditable() const;

#ifndef QT_NO_CONTEXTMENU
    bool swallowContextMenuEvent(QContextMenuEvent *event);
#endif
    void updatePositionDependentActions(ref const(QPoint) pos);

    QMenu *createStandardContextMenu();

    void setFeaturePermission(QWebFrame* frame, Feature feature, PermissionPolicy policy);

    QStringList supportedContentTypes() const;
    bool supportsContentType(ref const(QString) mimeType) const;

    enum Extension {
        ChooseMultipleFilesExtension,
        ErrorPageExtension
    };
    class ExtensionOption
    {};
    class ExtensionReturn
    {};

    class ChooseMultipleFilesExtensionOption : public ExtensionOption {
    public:
        QWebFrame *parentFrame;
        QStringList suggestedFileNames;
    };

    class ChooseMultipleFilesExtensionReturn : public ExtensionReturn {
    public:
        QStringList fileNames;
    };

    enum ErrorDomain { QtNetwork, Http, WebKit };
    class ErrorPageExtensionOption : public ExtensionOption {
    public:
        QUrl url;
        QWebFrame* frame;
        ErrorDomain domain;
        int error;
        QString errorString;
    };

    class ErrorPageExtensionReturn : public ExtensionReturn {
    public:
        ErrorPageExtensionReturn() : contentType(QLatin1String("text/html")), encoding(QLatin1String("utf-8")) {};
        QString contentType;
        QString encoding;
        QUrl baseUrl;
        QByteArray content;
    };


    /+virtual+/ bool extension(Extension extension, const(ExtensionOption)* option = 0, ExtensionReturn *output = 0);
    /+virtual+/ bool supportsExtension(Extension extension) const;

    QWebPageAdapter* handle() const;

    /+virtual+/ bool shouldInterruptJavaScript();

Q_SIGNALS:
    void loadStarted();
    void loadProgress(int progress);
    void loadFinished(bool ok);

    void linkHovered(ref const(QString) link, ref const(QString) title, ref const(QString) textContent);
    void statusBarMessage(ref const(QString) text);
    void selectionChanged();
    void frameCreated(QWebFrame *frame);
    void geometryChangeRequested(ref const(QRect) geom);
    void repaintRequested(ref const(QRect) dirtyRect);
    void scrollRequested(int dx, int dy, ref const(QRect) scrollViewRect);
    void windowCloseRequested();
    void printRequested(QWebFrame *frame);
    void linkClicked(ref const(QUrl) url);

    void toolBarVisibilityChangeRequested(bool visible);
    void statusBarVisibilityChangeRequested(bool visible);
    void menuBarVisibilityChangeRequested(bool visible);

    void unsupportedContent(QNetworkReply *reply);
    void downloadRequested(ref const(QNetworkRequest) request);

    void microFocusChanged();
    void contentsChanged();
    void databaseQuotaExceeded(QWebFrame* frame, QString databaseName);
    void applicationCacheQuotaExceeded(QWebSecurityOrigin* origin, quint64 defaultOriginQuota, quint64 totalSpaceNeeded);

    void saveFrameStateRequested(QWebFrame* frame, QWebHistoryItem* item);
    void restoreFrameStateRequested(QWebFrame* frame);

    void viewportChangeRequested();

    void featurePermissionRequested(QWebFrame* frame, QWebPage::Feature feature);
    void featurePermissionRequestCanceled(QWebFrame* frame, QWebPage::Feature feature);

protected:
    /+virtual+/ QWebPage *createWindow(WebWindowType type);
    /+virtual+/ QObject *createPlugin(ref const(QString) classid, ref const(QUrl) url, ref const(QStringList) paramNames, ref const(QStringList) paramValues);

    /+virtual+/ bool acceptNavigationRequest(QWebFrame *frame, ref const(QNetworkRequest) request, NavigationType type);
    /+virtual+/ QString chooseFile(QWebFrame *originatingFrame, ref const(QString) oldFile);
    /+virtual+/ void javaScriptAlert(QWebFrame *originatingFrame, ref const(QString) msg);
    /+virtual+/ bool javaScriptConfirm(QWebFrame *originatingFrame, ref const(QString) msg);
    /+virtual+/ bool javaScriptPrompt(QWebFrame *originatingFrame, ref const(QString) msg, ref const(QString) defaultValue, QString* result);
    /+virtual+/ void javaScriptConsoleMessage(ref const(QString) message, int lineNumber, ref const(QString) sourceID);

    /+virtual+/ QString userAgentForUrl(ref const(QUrl) url) const;

private:
    Q_PRIVATE_SLOT(d, void _q_onLoadProgressChanged(int))
#ifndef QT_NO_ACTION
    Q_PRIVATE_SLOT(d, void _q_webActionTriggered(bool checked))
#endif
    Q_PRIVATE_SLOT(d, void _q_cleanupLeakMessages())
    Q_PRIVATE_SLOT(d, void _q_updateScreen(QScreen*))

    QWebPagePrivate *d;

    friend class QWebFrame;
    friend class QWebPagePrivate;
    friend class QWebView;
    friend class QWebViewPrivate;
    friend class QGraphicsWebView;
    friend class QGraphicsWebViewPrivate;
    friend class QWebInspector;
    friend class WebCore::ChromeClientQt;
    friend class WebCore::EditorClientQt;
    friend class WebCore::FrameLoaderClientQt;
    friend class WebCore::InspectorClientQt;
    friend class WebCore::InspectorServerRequestHandlerQt;
    friend class WebCore::InspectorFrontendClientQt;
    friend class WebCore::ResourceHandle;
    friend class WebCore::QNetworkReplyHandler;
    friend class DumpRenderTreeSupportQt;
};

Q_DECLARE_OPERATORS_FOR_FLAGS(QWebPage::FindFlags)

#endif
