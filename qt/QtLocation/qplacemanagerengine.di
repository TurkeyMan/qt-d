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

#ifndef QPLACEMANAGERENGINE_H
#define QPLACEMANAGERENGINE_H

public import qt.QtLocation.QPlaceManager;

QT_BEGIN_NAMESPACE

class QPlaceManagerEnginePrivate;
class QPlaceMatchReply;
class QPlaceMatchRequest;
class QPlaceSearchReply;
class QPlaceSearchRequest;
class QPlaceSearchSuggestionReply;

class Q_LOCATION_EXPORT QPlaceManagerEngine : public QObject
{
    mixin Q_OBJECT;

public:
    QPlaceManagerEngine(ref const(QVariantMap) parameters, QObject *parent = 0);
    /+virtual+/ ~QPlaceManagerEngine();

    QString managerName() const;
    int managerVersion() const;

    /+virtual+/ QPlaceDetailsReply *getPlaceDetails(ref const(QString) placeId);

    /+virtual+/ QPlaceContentReply *getPlaceContent(ref const(QPlaceContentRequest) request);

    /+virtual+/ QPlaceSearchReply *search(ref const(QPlaceSearchRequest) request);

    /+virtual+/ QPlaceSearchSuggestionReply *searchSuggestions(ref const(QPlaceSearchRequest) request);

    /+virtual+/ QPlaceIdReply *savePlace(ref const(QPlace) place);
    /+virtual+/ QPlaceIdReply *removePlace(ref const(QString) placeId);

    /+virtual+/ QPlaceIdReply *saveCategory(ref const(QPlaceCategory) category, ref const(QString) parentId);
    /+virtual+/ QPlaceIdReply *removeCategory(ref const(QString) categoryId);

    /+virtual+/ QPlaceReply *initializeCategories();
    /+virtual+/ QString parentCategoryId(ref const(QString) categoryId) const;
    /+virtual+/ QStringList childCategoryIds(ref const(QString) categoryId) const;
    /+virtual+/ QPlaceCategory category(ref const(QString) categoryId) const;

    /+virtual+/ QList<QPlaceCategory> childCategories(ref const(QString) parentId) const;

    /+virtual+/ QList<QLocale> locales() const;
    /+virtual+/ void setLocales(ref const(QList<QLocale>) locales);

    /+virtual+/ QUrl constructIconUrl(ref const(QPlaceIcon) icon, ref const(QSize) size) const;

    /+virtual+/ QPlace compatiblePlace(ref const(QPlace) original) const;

    /+virtual+/ QPlaceMatchReply *matchingPlaces(ref const(QPlaceMatchRequest) request);

Q_SIGNALS:
    void finished(QPlaceReply *reply);
    void error(QPlaceReply *, QPlaceReply::Error error, ref const(QString) errorString = QString());

    void placeAdded(ref const(QString) placeId);
    void placeUpdated(ref const(QString) placeId);
    void placeRemoved(ref const(QString) placeId);

    void categoryAdded(ref const(QPlaceCategory) category, ref const(QString) parentCategoryId);
    void categoryUpdated(ref const(QPlaceCategory) category, ref const(QString) parentCategoryId);
    void categoryRemoved(ref const(QString) categoryId, ref const(QString) parentCategoryId);
    void dataChanged();

protected:
    QPlaceManager *manager() const;

private:
    void setManagerName(ref const(QString) managerName);
    void setManagerVersion(int managerVersion);

    QPlaceManagerEnginePrivate *d_ptr;
    mixin Q_DISABLE_COPY;

    friend class QGeoServiceProviderPrivate;
    friend class QPlaceManager;
};

QT_END_NAMESPACE

#endif
