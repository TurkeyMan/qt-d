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

#ifndef QPLACEMANAGER_H
#define QPLACEMANAGER_H

public import qt.QtLocation.QPlaceContentReply;
public import qt.QtLocation.QPlaceContentRequest;
public import qt.QtLocation.QPlaceIdReply;
public import qt.QtLocation.QPlaceReply;
public import qt.QtLocation.QPlaceDetailsReply;
public import qt.QtLocation.QPlaceMatchReply;
public import qt.QtLocation.QPlaceMatchRequest;
public import qt.QtLocation.QPlaceSearchSuggestionReply;
public import qt.QtLocation.QPlaceSearchRequest;
public import qt.QtLocation.QPlaceSearchResult;

public import qt.QtCore.QLocale;
public import qt.QtCore.QVector;
public import qt.QtCore.QString;
public import qt.QtCore.QObject;
public import qt.QtLocation.QPlaceIcon;

QT_BEGIN_NAMESPACE

class QPlaceManagerEngine;
class QPlaceSearchRequest;
class QPlaceSearchReply;

class Q_LOCATION_EXPORT QPlaceManager : public QObject
{
    mixin Q_OBJECT;
public:
    ~QPlaceManager();

    QString managerName() const;
    int managerVersion() const;

    QPlaceDetailsReply *getPlaceDetails(ref const(QString) placeId) const;

    QPlaceContentReply *getPlaceContent(ref const(QPlaceContentRequest) request) const;

    QPlaceSearchReply *search(ref const(QPlaceSearchRequest) query) const;

    QPlaceSearchSuggestionReply *searchSuggestions(ref const(QPlaceSearchRequest) request) const;

    QPlaceIdReply *savePlace(ref const(QPlace) place);
    QPlaceIdReply *removePlace(ref const(QString) placeId);

    QPlaceIdReply *saveCategory(ref const(QPlaceCategory) category, ref const(QString) parentId = QString());
    QPlaceIdReply *removeCategory(ref const(QString) categoryId);

    QPlaceReply *initializeCategories();
    QString parentCategoryId(ref const(QString) categoryId) const;
    QStringList childCategoryIds(ref const(QString) parentId = QString()) const;

    QPlaceCategory category(ref const(QString) categoryId) const;
    QList<QPlaceCategory> childCategories(ref const(QString) parentId = QString()) const;

    QList<QLocale> locales() const;
    void setLocale(ref const(QLocale) locale);
    void setLocales(ref const(QList<QLocale>) locale);

    QPlace compatiblePlace(ref const(QPlace) place);

    QPlaceMatchReply *matchingPlaces(ref const(QPlaceMatchRequest) request) const;

Q_SIGNALS:
    void finished(QPlaceReply *reply);
    void error(QPlaceReply *, QPlaceReply::Error error, ref const(QString) errorString = QString());

    void placeAdded(ref const(QString) placeId);
    void placeUpdated(ref const(QString) placeId);
    void placeRemoved(ref const(QString) placeId);

    void categoryAdded(ref const(QPlaceCategory) category, ref const(QString) parentId);
    void categoryUpdated(ref const(QPlaceCategory) category, ref const(QString) parentId);
    void categoryRemoved(ref const(QString) categoryId, ref const(QString) parentId);
    void dataChanged();

private:
    QPlaceManager(QPlaceManagerEngine *engine, QObject *parent = 0);
    mixin Q_DISABLE_COPY;

    QPlaceManagerEngine *d;

    friend class QGeoServiceProvider;
    friend class QGeoServiceProviderPrivate;
    friend class QPlaceIcon;
};

QT_END_NAMESPACE

#endif // QPLACEMANAGER_H
