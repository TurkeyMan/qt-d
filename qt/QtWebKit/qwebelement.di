/*
    Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies)

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

#ifndef QWEBELEMENT_H
#define QWEBELEMENT_H

public import qt.QtCore.qstring;
public import qt.QtCore.qstringlist;
public import qt.QtCore.qrect;
public import qt.QtCore.qvariant;
public import qt.QtCore.qshareddata;

public import qt.qwebkitglobal;
namespace WebCore {
    class Element;
    class Node;
}

QT_BEGIN_NAMESPACE
class QPainter;
QT_END_NAMESPACE

class QWebFrame;
class QWebElementCollection;
class QWebElementPrivate;

class QWEBKIT_EXPORT QWebElement {
public:
    QWebElement();
    QWebElement(ref const(QWebElement));
    QWebElement &operator=(ref const(QWebElement));
    ~QWebElement();

    bool operator==(ref const(QWebElement) o) const;
    bool operator!=(ref const(QWebElement) o) const;

    bool isNull() const;

    QWebElementCollection findAll(ref const(QString) selectorQuery) const;
    QWebElement findFirst(ref const(QString) selectorQuery) const;

    void setPlainText(ref const(QString) text);
    QString toPlainText() const;

    void setOuterXml(ref const(QString) markup);
    QString toOuterXml() const;

    void setInnerXml(ref const(QString) markup);
    QString toInnerXml() const;

    void setAttribute(ref const(QString) name, ref const(QString) value);
    void setAttributeNS(ref const(QString) namespaceUri, ref const(QString) name, ref const(QString) value);
    QString attribute(ref const(QString) name, ref const(QString) defaultValue = QString()) const;
    QString attributeNS(ref const(QString) namespaceUri, ref const(QString) name, ref const(QString) defaultValue = QString()) const;
    bool hasAttribute(ref const(QString) name) const;
    bool hasAttributeNS(ref const(QString) namespaceUri, ref const(QString) name) const;
    void removeAttribute(ref const(QString) name);
    void removeAttributeNS(ref const(QString) namespaceUri, ref const(QString) name);
    bool hasAttributes() const;
    QStringList attributeNames(ref const(QString) namespaceUri = QString()) const;

    QStringList classes() const;
    bool hasClass(ref const(QString) name) const;
    void addClass(ref const(QString) name);
    void removeClass(ref const(QString) name);
    void toggleClass(ref const(QString) name);

    bool hasFocus() const;
    void setFocus();

    QRect geometry() const;

    QString tagName() const;
    QString prefix() const;
    QString localName() const;
    QString namespaceUri() const;

    QWebElement parent() const;
    QWebElement firstChild() const;
    QWebElement lastChild() const;
    QWebElement nextSibling() const;
    QWebElement previousSibling() const;
    QWebElement document() const;
    QWebFrame *webFrame() const;

    // TODO: Add QWebElementCollection overloads
    // docs need example snippet
    void appendInside(ref const(QString) markup);
    void appendInside(ref const(QWebElement) element);

    // docs need example snippet
    void prependInside(ref const(QString) markup);
    void prependInside(ref const(QWebElement) element);

    // docs need example snippet
    void appendOutside(ref const(QString) markup);
    void appendOutside(ref const(QWebElement) element);

    // docs need example snippet
    void prependOutside(ref const(QString) markup);
    void prependOutside(ref const(QWebElement) element);

    // docs need example snippet
    void encloseContentsWith(ref const(QWebElement) element);
    void encloseContentsWith(ref const(QString) markup);
    void encloseWith(ref const(QString) markup);
    void encloseWith(ref const(QWebElement) element);

    void replace(ref const(QString) markup);
    void replace(ref const(QWebElement) element);

    QWebElement clone() const;
    QWebElement& takeFromDocument();
    void removeFromDocument();
    void removeAllChildren();

    QVariant evaluateJavaScript(ref const(QString) scriptSource);

    enum StyleResolveStrategy {
         InlineStyle,
         CascadedStyle,
         ComputedStyle
    };
    QString styleProperty(ref const(QString) name, StyleResolveStrategy strategy) const;
    void setStyleProperty(ref const(QString) name, ref const(QString) value);

    void render(QPainter* painter);
    void render(QPainter* painter, ref const(QRect) clipRect);

private:
    explicit QWebElement(WebCore::Element*);
    explicit QWebElement(WebCore::Node*);

    static QWebElement enclosingElement(WebCore::Node*);

    friend class DumpRenderTreeSupportQt;
    friend class QWebFrameAdapter;
    friend class QWebElementCollection;
    friend class QWebHitTestResult;
    friend class QWebHitTestResultPrivate;
    friend class QWebPage;
    friend class QWebPagePrivate;
    friend class QtWebElementRuntime;

    QWebElementPrivate* d;
    WebCore::Element* m_element;
};

class QWebElementCollectionPrivate;

class QWEBKIT_EXPORT QWebElementCollection
{
public:
    QWebElementCollection();
    QWebElementCollection(ref const(QWebElement) contextElement, ref const(QString) query);
    QWebElementCollection(ref const(QWebElementCollection) );
    QWebElementCollection &operator=(ref const(QWebElementCollection) );
    ~QWebElementCollection();

    QWebElementCollection operator+(ref const(QWebElementCollection) other) const;
    /+inline+/ QWebElementCollection &operator+=(ref const(QWebElementCollection) other)
    {
        append(other); return *this;
    }

    void append(ref const(QWebElementCollection) collection);

    int count() const;
    QWebElement at(int i) const;
    /+inline+/ QWebElement operator[](int i) const { return at(i); }

    /+inline+/ QWebElement first() const { return at(0); }
    /+inline+/ QWebElement last() const { return at(count() - 1); }

    QList<QWebElement> toList() const;

    class const_iterator {
       public:
           /+inline+/ const_iterator(const(QWebElementCollection)* collection_, int index) : i(index), collection(collection_) {}
           /+inline+/ const_iterator(ref const(const_iterator) o) : i(o.i), collection(o.collection) {}

           /+inline+/ const QWebElement operator*() const { return collection->at(i); }

           /+inline+/ bool operator==(ref const(const_iterator) o) const { return i == o.i && collection == o.collection; }
           /+inline+/ bool operator!=(ref const(const_iterator) o) const { return i != o.i || collection != o.collection; }
           /+inline+/ bool operator<(ref const(const_iterator) o) const { return i < o.i; }
           /+inline+/ bool operator<=(ref const(const_iterator) o) const { return i <= o.i; }
           /+inline+/ bool operator>(ref const(const_iterator) o) const { return i > o.i; }
           /+inline+/ bool operator>=(ref const(const_iterator) o) const { return i >= o.i; }

           /+inline+/ const_iterator& operator++() { ++i; return *this; }
           /+inline+/ const_iterator operator++(int) { const_iterator n(collection, i); ++i; return n; }
           /+inline+/ const_iterator& operator--() { i--; return *this; }
           /+inline+/ const_iterator operator--(int) { const_iterator n(collection, i); i--; return n; }
           /+inline+/ const_iterator& operator+=(int j) { i += j; return *this; }
           /+inline+/ const_iterator& operator-=(int j) { i -= j; return *this; }
           /+inline+/ const_iterator operator+(int j) const { return const_iterator(collection, i + j); }
           /+inline+/ const_iterator operator-(int j) const { return const_iterator(collection, i - j); }
           /+inline+/ int operator-(const_iterator j) const { return i - j.i; }
       private:
            int i;
            const(QWebElementCollection)* const collection;
    };
    friend class const_iterator;

    /+inline+/ const_iterator begin() const { return constBegin(); }
    /+inline+/ const_iterator end() const { return constEnd(); }
    /+inline+/ const_iterator constBegin() const { return const_iterator(this, 0); }
    /+inline+/ const_iterator constEnd() const { return const_iterator(this, count()); };

    class iterator {
    public:
        /+inline+/ iterator(const(QWebElementCollection)* collection_, int index) : i(index), collection(collection_) {}
        /+inline+/ iterator(ref const(iterator) o) : i(o.i), collection(o.collection) {}

        /+inline+/ QWebElement operator*() const { return collection->at(i); }

        /+inline+/ bool operator==(ref const(iterator) o) const { return i == o.i && collection == o.collection; }
        /+inline+/ bool operator!=(ref const(iterator) o) const { return i != o.i || collection != o.collection; }
        /+inline+/ bool operator<(ref const(iterator) o) const { return i < o.i; }
        /+inline+/ bool operator<=(ref const(iterator) o) const { return i <= o.i; }
        /+inline+/ bool operator>(ref const(iterator) o) const { return i > o.i; }
        /+inline+/ bool operator>=(ref const(iterator) o) const { return i >= o.i; }

        /+inline+/ iterator& operator++() { ++i; return *this; }
        /+inline+/ iterator operator++(int) { iterator n(collection, i); ++i; return n; }
        /+inline+/ iterator& operator--() { i--; return *this; }
        /+inline+/ iterator operator--(int) { iterator n(collection, i); i--; return n; }
        /+inline+/ iterator& operator+=(int j) { i += j; return *this; }
        /+inline+/ iterator& operator-=(int j) { i -= j; return *this; }
        /+inline+/ iterator operator+(int j) const { return iterator(collection, i + j); }
        /+inline+/ iterator operator-(int j) const { return iterator(collection, i - j); }
        /+inline+/ int operator-(iterator j) const { return i - j.i; }
    private:
        int i;
        const(QWebElementCollection)* const collection;
    };
    friend class iterator;

    /+inline+/ iterator begin() { return iterator(this, 0); }
    /+inline+/ iterator end()  { return iterator(this, count()); }
private:
    QExplicitlySharedDataPointer<QWebElementCollectionPrivate> d;
};

Q_DECLARE_METATYPE(QWebElement)

#endif // QWEBELEMENT_H
