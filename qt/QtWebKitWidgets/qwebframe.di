/*
    Copyright (C) 2008,2009 Nokia Corporation and/or its subsidiary(-ies)
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

#ifndef QWEBFRAME_H
#define QWEBFRAME_H

public import qt.QtCore.qobject;
public import qt.QtCore.qurl;
public import qt.QtCore.qvariant;
public import qt.QtGui.qicon;
public import qt.QtNetwork.qnetworkaccessmanager;
public import qt.QtWebKit.qwebkitglobal;

QT_BEGIN_NAMESPACE
class QRect;
class QPoint;
class QPainter;
class QPixmap;
class QMouseEvent;
class QWheelEvent;
class QNetworkRequest;
class QRegion;
class QPrinter;
QT_END_NAMESPACE

class QWebNetworkRequest;
class QWebFrameAdapter;
class QWebFramePrivate;
class QWebPage;
class QWebPageAdapter;
class QWebHitTestResult;
class QWebHistoryItem;
class QWebSecurityOrigin;
class QWebElement;
class QWebElementCollection;
class QWebScriptWorld;

class DumpRenderTreeSupportQt;
namespace WebCore {
    class WidgetPrivate;
    class FrameLoaderClientQt;
    class ChromeClientQt;
    class TextureMapperLayerClientQt;
}
class QWebFrameData;
class QWebHitTestResultPrivate;
class QWebFrame;

class QWEBKITWIDGETS_EXPORT QWebHitTestResult {
public:
    QWebHitTestResult();
    QWebHitTestResult(ref const(QWebHitTestResult) other);
    QWebHitTestResult &operator=(ref const(QWebHitTestResult) other);
    ~QWebHitTestResult();

    bool isNull() const;

    QPoint pos() const;
    QRect boundingRect() const;
    QWebElement enclosingBlockElement() const;
    QString title() const;

    QString linkText() const;
    QUrl linkUrl() const;
    QUrl linkTitle() const;
    QWebFrame *linkTargetFrame() const;
    QWebElement linkElement() const;

    QString alternateText() const; // for img, area, input and applet

    QUrl imageUrl() const;
    QPixmap pixmap() const;
    QUrl mediaUrl() const;

    bool isContentEditable() const;
    bool isContentSelected() const;

    QWebElement element() const;

    QWebFrame *frame() const;

private:
    QWebHitTestResult(QWebHitTestResultPrivate *priv);
    QWebHitTestResultPrivate *d;

    friend class QWebFrame;
    friend class QWebPagePrivate;
    friend class QWebPage;
};

class QWEBKITWIDGETS_EXPORT QWebFrame : public QObject {
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(qreal, "textSizeMultiplier", "READ", "textSizeMultiplier", "WRITE", "setTextSizeMultiplier", "DESIGNABLE", "false");
    mixin Q_PROPERTY!(qreal, "zoomFactor", "READ", "zoomFactor", "WRITE", "setZoomFactor");
    mixin Q_PROPERTY!(QString, "title", "READ", "title");
    mixin Q_PROPERTY!(QUrl, "url", "READ", "url", "WRITE", "setUrl");
    mixin Q_PROPERTY!(QUrl, "requestedUrl", "READ", "requestedUrl");
    mixin Q_PROPERTY!(QUrl, "baseUrl", "READ", "baseUrl");
    mixin Q_PROPERTY!(QIcon, "icon", "READ", "icon");
    mixin Q_PROPERTY!(QSize, "contentsSize", "READ", "contentsSize");
    mixin Q_PROPERTY!(QPoint, "scrollPosition", "READ", "scrollPosition", "WRITE", "setScrollPosition");
    mixin Q_PROPERTY!(bool, "focus", "READ", "hasFocus");
private:
    QWebFrame(QWebPage *parentPage);
    QWebFrame(QWebFrame* parent, QWebFrameData*);
    ~QWebFrame();

public:
    enum ValueOwnership {
        QtOwnership,
        ScriptOwnership,
        AutoOwnership
    };

    QWebPage *page() const;

    void load(ref const(QUrl) url);
    void load(ref const(QNetworkRequest) request, QNetworkAccessManager::Operation operation = QNetworkAccessManager::GetOperation, ref const(QByteArray) body = QByteArray());
    void setHtml(ref const(QString) html, ref const(QUrl) baseUrl = QUrl());
    void setContent(ref const(QByteArray) data, ref const(QString) mimeType = QString(), ref const(QUrl) baseUrl = QUrl());

    void addToJavaScriptWindowObject(ref const(QString) name, QObject *object, ValueOwnership ownership = QtOwnership);
    QString toHtml() const;
    QString toPlainText() const;

    QString title() const;
    void setUrl(ref const(QUrl) url);
    QUrl url() const;
    QUrl requestedUrl() const;
    QUrl baseUrl() const;
    QIcon icon() const;
    QMultiMap<QString, QString> metaData() const;

    QString frameName() const;

    QWebFrame *parentFrame() const;
    QList<QWebFrame*> childFrames() const;

    Qt.ScrollBarPolicy scrollBarPolicy(Qt.Orientation orientation) const;
    void setScrollBarPolicy(Qt.Orientation orientation, Qt.ScrollBarPolicy policy);

    void setScrollBarValue(Qt.Orientation orientation, int value);
    int scrollBarValue(Qt.Orientation orientation) const;
    int scrollBarMinimum(Qt.Orientation orientation) const;
    int scrollBarMaximum(Qt.Orientation orientation) const;
    QRect scrollBarGeometry(Qt.Orientation orientation) const;

    void scroll(int, int);
    QPoint scrollPosition() const;
    void setScrollPosition(ref const(QPoint) pos);

    void scrollToAnchor(ref const(QString) anchor);

    enum RenderLayer {
        ContentsLayer = 0x10,
        ScrollBarLayer = 0x20,
        PanIconLayer = 0x40,

        AllLayers = 0xff
    };
    Q_DECLARE_FLAGS(RenderLayers, RenderLayer)

    void render(QPainter*, ref const(QRegion) clip = QRegion());
    void render(QPainter*, RenderLayers layer, ref const(QRegion) clip = QRegion());

    void setTextSizeMultiplier(qreal factor);
    qreal textSizeMultiplier() const;

    qreal zoomFactor() const;
    void setZoomFactor(qreal factor);

    bool hasFocus() const;
    void setFocus();

    QPoint pos() const;
    QRect geometry() const;
    QSize contentsSize() const;

    QWebElement documentElement() const;
    QWebElementCollection findAllElements(ref const(QString) selectorQuery) const;
    QWebElement findFirstElement(ref const(QString) selectorQuery) const;

    QWebHitTestResult hitTestContent(ref const(QPoint) pos) const;

    /+virtual+/ bool event(QEvent *);

    QWebSecurityOrigin securityOrigin() const;
    QWebFrameAdapter* handle() const;

public Q_SLOTS:
    QVariant evaluateJavaScript(ref const(QString) scriptSource);
#ifndef QT_NO_PRINTER
    void print(QPrinter *printer) const;
#endif

Q_SIGNALS:
    void javaScriptWindowObjectCleared();

    void provisionalLoad();
    void titleChanged(ref const(QString) title);
    void urlChanged(ref const(QUrl) url);

    void initialLayoutCompleted();

    void iconChanged();

    void contentsSizeChanged(ref const(QSize) size);

    void loadStarted();
    void loadFinished(bool ok);

    void pageChanged();

private:
    friend class QGraphicsWebView;
    friend class QWebPage;
    friend class QWebPagePrivate;
    friend class QWebFramePrivate;
    friend class DumpRenderTreeSupportQt;
    friend class WebCore::WidgetPrivate;
    friend class WebCore::FrameLoaderClientQt;
    friend class WebCore::ChromeClientQt;
    friend class WebCore::TextureMapperLayerClientQt;
    QWebFramePrivate *d;
    Q_PRIVATE_SLOT(d, void _q_orientationChanged())
};

Q_DECLARE_OPERATORS_FOR_FLAGS(QWebFrame::RenderLayers)

#endif
