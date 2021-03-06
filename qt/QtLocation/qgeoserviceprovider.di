/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtLocation module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL21$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and Digia. For licensing terms and
** conditions see http://qt.digia.com/licensing. For further information
** use the contact form at http://qt.digia.com/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 or version 3 as published by the Free
** Software Foundation and appearing in the file LICENSE.LGPLv21 and
** LICENSE.LGPLv3 included in the packaging of this file. Please review the
** following information to ensure the GNU Lesser General Public License
** requirements will be met: https://www.gnu.org/licenses/lgpl.html and
** http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Digia gives you certain additional
** rights. These rights are described in the Digia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** $QT_END_LICENSE$
**
****************************************************************************/

#ifndef QGEOSERVICEPROVIDER_H
#define QGEOSERVICEPROVIDER_H

public import qt.QtCore.QVariant;
public import qt.QtCore.QString;
public import qt.QtCore.QObject;
public import qt.QtLocation.qlocationglobal;

QT_BEGIN_NAMESPACE

class QLocale;
class QStringList;
class QGeoCodingManager;
class QGeoMappingManager;
class QGeoRoutingManager;
class QPlaceManager;
class QGeoCodingManagerEngine;
class QGeoMappingManagerEngine;
class QGeoRoutingManagerEngine;
class QPlaceManagerEngine;
class QGeoServiceProviderPrivate;

class Q_LOCATION_EXPORT QGeoServiceProvider : public QObject
{
    mixin Q_OBJECT;

public:
    enum Error {
        NoError,
        NotSupportedError,
        UnknownParameterError,
        MissingRequiredParameterError,
        ConnectionError
    };

    enum RoutingFeature {
        NoRoutingFeatures               = 0,
        OnlineRoutingFeature            = (1<<0),
        OfflineRoutingFeature           = (1<<1),
        LocalizedRoutingFeature         = (1<<2),
        RouteUpdatesFeature             = (1<<3),
        AlternativeRoutesFeature        = (1<<4),
        ExcludeAreasRoutingFeature      = (1<<5),
        AnyRoutingFeatures              = ~(0)
    };

    enum GeocodingFeature {
        NoGeocodingFeatures             = 0,
        OnlineGeocodingFeature          = (1<<0),
        OfflineGeocodingFeature         = (1<<1),
        ReverseGeocodingFeature         = (1<<2),
        LocalizedGeocodingFeature       = (1<<3),
        AnyGeocodingFeatures            = ~(0)
    };

    enum MappingFeature {
        NoMappingFeatures               = 0,
        OnlineMappingFeature            = (1<<0),
        OfflineMappingFeature           = (1<<1),
        LocalizedMappingFeature         = (1<<2),
        AnyMappingFeatures              = ~(0)
    };

    enum PlacesFeature {
        NoPlacesFeatures                = 0,
        OnlinePlacesFeature             = (1<<0),
        OfflinePlacesFeature            = (1<<1),
        SavePlaceFeature                = (1<<2),
        RemovePlaceFeature              = (1<<3),
        SaveCategoryFeature             = (1<<4),
        RemoveCategoryFeature           = (1<<5),
        PlaceRecommendationsFeature     = (1<<6),
        SearchSuggestionsFeature        = (1<<7),
        LocalizedPlacesFeature          = (1<<8),
        NotificationsFeature            = (1<<9),
        PlaceMatchingFeature            = (1<<10),
        AnyPlacesFeatures               = ~(0)
    };

    Q_DECLARE_FLAGS(RoutingFeatures, RoutingFeature)
    Q_FLAGS(RoutingFeatures)

    Q_DECLARE_FLAGS(GeocodingFeatures, GeocodingFeature)
    Q_FLAGS(GeocodingFeatures)

    Q_DECLARE_FLAGS(MappingFeatures, MappingFeature)
    Q_FLAGS(MappingFeatures)

    Q_DECLARE_FLAGS(PlacesFeatures, PlacesFeature)
    Q_FLAGS(PlacesFeatures)

    static QStringList availableServiceProviders();
    QGeoServiceProvider(ref const(QString) providerName,
                        ref const(QVariantMap) parameters = QVariantMap(),
                        bool allowExperimental = false);

    ~QGeoServiceProvider();

    RoutingFeatures routingFeatures() const;
    GeocodingFeatures geocodingFeatures() const;
    MappingFeatures mappingFeatures() const;
    PlacesFeatures placesFeatures() const;

    QGeoCodingManager *geocodingManager() const;
    QGeoMappingManager *mappingManager() const;
    QGeoRoutingManager *routingManager() const;
    QPlaceManager *placeManager() const;

    Error error() const;
    QString errorString() const;

    void setParameters(ref const(QVariantMap) parameters);
    void setLocale(ref const(QLocale) locale);
    void setAllowExperimental(bool allow);

private:
    QGeoServiceProviderPrivate *d_ptr;
};

Q_DECLARE_OPERATORS_FOR_FLAGS(QGeoServiceProvider::RoutingFeatures)
Q_DECLARE_OPERATORS_FOR_FLAGS(QGeoServiceProvider::GeocodingFeatures)
Q_DECLARE_OPERATORS_FOR_FLAGS(QGeoServiceProvider::MappingFeatures)
Q_DECLARE_OPERATORS_FOR_FLAGS(QGeoServiceProvider::PlacesFeatures)

QT_END_NAMESPACE

#endif
