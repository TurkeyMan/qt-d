/*
    Copyright (C) 2008 Nokia Corporation and/or its subsidiary(-ies)

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

#ifndef QWEBSETTINGS_H
#define QWEBSETTINGS_H

public import qt.qwebkitglobal;

public import qt.QtCore.qstring;
public import qt.QtGui.qpixmap;
public import qt.QtGui.qicon;
public import qt.QtCore.qshareddata;

namespace WebCore {
    class GroupSettings;
    class Settings;
}

class QWebPage;
class QWebPluginDatabase;
class QWebSettingsPrivate;
QT_BEGIN_NAMESPACE
class QUrl;
QT_END_NAMESPACE

QWEBKIT_EXPORT void qt_networkAccessAllowed(bool isAllowed);

class QWEBKIT_EXPORT QWebSettings {
public:
    enum FontFamily {
        StandardFont,
        FixedFont,
        SerifFont,
        SansSerifFont,
        CursiveFont,
        FantasyFont
    };
    enum WebAttribute {
        AutoLoadImages,
        JavascriptEnabled,
        JavaEnabled,
        PluginsEnabled,
        PrivateBrowsingEnabled,
        JavascriptCanOpenWindows,
        JavascriptCanAccessClipboard,
        DeveloperExtrasEnabled,
        LinksIncludedInFocusChain,
        ZoomTextOnly,
        PrintElementBackgrounds,
        OfflineStorageDatabaseEnabled,
        OfflineWebApplicationCacheEnabled,
        LocalStorageEnabled,
#if defined(QT_DEPRECATED) || defined(qdoc)
        LocalStorageDatabaseEnabled = LocalStorageEnabled,
#endif
        LocalContentCanAccessRemoteUrls,
        DnsPrefetchEnabled,
        XSSAuditingEnabled,
        AcceleratedCompositingEnabled,
        SpatialNavigationEnabled,
        LocalContentCanAccessFileUrls,
        TiledBackingStoreEnabled,
        FrameFlatteningEnabled,
        SiteSpecificQuirksEnabled,
        JavascriptCanCloseWindows,
        WebGLEnabled,
        CSSRegionsEnabled,
        HyperlinkAuditingEnabled,
        CSSGridLayoutEnabled,
        ScrollAnimatorEnabled,
        CaretBrowsingEnabled,
        NotificationsEnabled,
        WebAudioEnabled,
        Accelerated2dCanvasEnabled
    };
    enum WebGraphic {
        MissingImageGraphic,
        MissingPluginGraphic,
        DefaultFrameIconGraphic,
        TextAreaSizeGripCornerGraphic,
        DeleteButtonGraphic,
        InputSpeechButtonGraphic,
        SearchCancelButtonGraphic,
        SearchCancelButtonPressedGraphic
    };
    enum FontSize {
        MinimumFontSize,
        MinimumLogicalFontSize,
        DefaultFontSize,
        DefaultFixedFontSize
    };
    enum ThirdPartyCookiePolicy {
        AlwaysAllowThirdPartyCookies,
        AlwaysBlockThirdPartyCookies,
        AllowThirdPartyWithExistingCookies
    };

    static QWebSettings *globalSettings();

    void setFontFamily(FontFamily which, ref const(QString) family);
    QString fontFamily(FontFamily which) const;
    void resetFontFamily(FontFamily which);

    void setFontSize(FontSize type, int size);
    int fontSize(FontSize type) const;
    void resetFontSize(FontSize type);

    void setAttribute(WebAttribute attr, bool on);
    bool testAttribute(WebAttribute attr) const;
    void resetAttribute(WebAttribute attr);

    void setUserStyleSheetUrl(ref const(QUrl) location);
    QUrl userStyleSheetUrl() const;

    void setDefaultTextEncoding(ref const(QString) encoding);
    QString defaultTextEncoding() const;

    static void setIconDatabasePath(ref const(QString) location);
    static QString iconDatabasePath();
    static void clearIconDatabase();
    static QIcon iconForUrl(ref const(QUrl) url);

    //static QWebPluginDatabase *pluginDatabase();

    static void setWebGraphic(WebGraphic type, ref const(QPixmap) graphic);
    static QPixmap webGraphic(WebGraphic type);

    static void setMaximumPagesInCache(int pages);
    static int maximumPagesInCache();
    static void setObjectCacheCapacities(int cacheMinDeadCapacity, int cacheMaxDead, int totalCapacity);

    static void setOfflineStoragePath(ref const(QString) path);
    static QString offlineStoragePath();
    static void setOfflineStorageDefaultQuota(qint64 maximumSize);
    static qint64 offlineStorageDefaultQuota();

    static void setOfflineWebApplicationCachePath(ref const(QString) path);
    static QString offlineWebApplicationCachePath();
    static void setOfflineWebApplicationCacheQuota(qint64 maximumSize);
    static qint64 offlineWebApplicationCacheQuota();
    
    void setLocalStoragePath(ref const(QString) path);
    QString localStoragePath() const; 

    static void clearMemoryCaches();

    static void enablePersistentStorage(ref const(QString) path = QString());

    void setThirdPartyCookiePolicy(ThirdPartyCookiePolicy);
    QWebSettings::ThirdPartyCookiePolicy thirdPartyCookiePolicy() const;

    void setCSSMediaType(ref const(QString));
    QString cssMediaType() const;

    /+inline+/ QWebSettingsPrivate* handle() const { return d; }

private:
    friend class QWebPageAdapter;
    friend class QWebPagePrivate;
    friend class QWebSettingsPrivate;

    mixin Q_DISABLE_COPY;

    QWebSettings();
    QWebSettings(WebCore::Settings *settings, WebCore::GroupSettings *groupSettings);
    ~QWebSettings();

    QWebSettingsPrivate *d;
};

#endif
