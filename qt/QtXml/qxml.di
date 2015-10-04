/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtXml module of the Qt Toolkit.
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

#ifndef QXML_H
#define QXML_H

public import qt.QtXml.qtxmlglobal;
public import qt.QtCore.qtextstream;
public import qt.QtCore.qfile;
public import qt.QtCore.qstring;
public import qt.QtCore.qstringlist;
public import qt.QtCore.qlist;
public import qt.QtCore.qscopedpointer;

QT_BEGIN_NAMESPACE


class QXmlNamespaceSupport;
class QXmlAttributes;
class QXmlContentHandler;
class QXmlDefaultHandler;
class QXmlDTDHandler;
class QXmlEntityResolver;
class QXmlErrorHandler;
class QXmlLexicalHandler;
class QXmlDeclHandler;
class QXmlInputSource;
class QXmlLocator;
class QXmlNamespaceSupport;
class QXmlParseException;

class QXmlReader;
class QXmlSimpleReader;

class QXmlSimpleReaderPrivate;
class QXmlNamespaceSupportPrivate;
class QXmlAttributesPrivate;
class QXmlInputSourcePrivate;
class QXmlParseExceptionPrivate;
class QXmlLocatorPrivate;
class QXmlDefaultHandlerPrivate;


//
// SAX Namespace Support
//

class Q_XML_EXPORT QXmlNamespaceSupport
{
public:
    QXmlNamespaceSupport();
    ~QXmlNamespaceSupport();

    void setPrefix(ref const(QString), ref const(QString));

    QString prefix(ref const(QString)) const;
    QString uri(ref const(QString)) const;
    void splitName(ref const(QString), QString&, QString&) const;
    void processName(ref const(QString), bool, QString&, QString&) const;
    QStringList prefixes() const;
    QStringList prefixes(ref const(QString)) const;

    void pushContext();
    void popContext();
    void reset();

private:
    QXmlNamespaceSupportPrivate *d;

    friend class QXmlSimpleReaderPrivate;
    mixin Q_DISABLE_COPY;
};


//
// SAX Attributes
//

class Q_XML_EXPORT QXmlAttributes
{
public:
    QXmlAttributes();
    /+virtual+/ ~QXmlAttributes();

    int index(ref const(QString) qName) const;
    int index(QLatin1String qName) const;
    int index(ref const(QString) uri, ref const(QString) localPart) const;
    int length() const;
    int count() const;
    QString localName(int index) const;
    QString qName(int index) const;
    QString uri(int index) const;
    QString type(int index) const;
    QString type(ref const(QString) qName) const;
    QString type(ref const(QString) uri, ref const(QString) localName) const;
    QString value(int index) const;
    QString value(ref const(QString) qName) const;
    QString value(QLatin1String qName) const;
    QString value(ref const(QString) uri, ref const(QString) localName) const;

    void clear();
    void append(ref const(QString) qName, ref const(QString) uri, ref const(QString) localPart, ref const(QString) value);

private:
    struct Attribute {
        QString qname, uri, localname, value;
    };
    typedef QList<Attribute> AttributeList;
    AttributeList attList;

    QXmlAttributesPrivate *d;
};

//
// SAX Input Source
//

class Q_XML_EXPORT QXmlInputSource
{
public:
    QXmlInputSource();
    explicit QXmlInputSource(QIODevice *dev);
    /+virtual+/ ~QXmlInputSource();

    /+virtual+/ void setData(ref const(QString) dat);
    /+virtual+/ void setData(ref const(QByteArray) dat);
    /+virtual+/ void fetchData();
    /+virtual+/ QString data() const;
    /+virtual+/ QChar next();
    /+virtual+/ void reset();

    static const ushort EndOfData;
    static const ushort EndOfDocument;

protected:
    /+virtual+/ QString fromRawData(ref const(QByteArray) data, bool beginning = false);

private:
    void init();
    QXmlInputSourcePrivate *d;
};

//
// SAX Exception Classes
//

class Q_XML_EXPORT QXmlParseException
{
public:
    explicit QXmlParseException(ref const(QString) name = QString(), int c = -1, int l = -1,
                                ref const(QString) p = QString(), ref const(QString) s = QString());
    QXmlParseException(ref const(QXmlParseException) other);
    ~QXmlParseException();

    int columnNumber() const;
    int lineNumber() const;
    QString publicId() const;
    QString systemId() const;
    QString message() const;

private:
    QScopedPointer<QXmlParseExceptionPrivate> d;
};


//
// XML Reader
//

class Q_XML_EXPORT QXmlReader
{
public:
    /+virtual+/ ~QXmlReader() {}
    /+virtual+/ bool feature(ref const(QString) name, bool *ok = 0) const = 0;
    /+virtual+/ void setFeature(ref const(QString) name, bool value) = 0;
    /+virtual+/ bool hasFeature(ref const(QString) name) const = 0;
    /+virtual+/ void* property(ref const(QString) name, bool *ok = 0) const = 0;
    /+virtual+/ void setProperty(ref const(QString) name, void* value) = 0;
    /+virtual+/ bool hasProperty(ref const(QString) name) const = 0;
    /+virtual+/ void setEntityResolver(QXmlEntityResolver* handler) = 0;
    /+virtual+/ QXmlEntityResolver* entityResolver() const = 0;
    /+virtual+/ void setDTDHandler(QXmlDTDHandler* handler) = 0;
    /+virtual+/ QXmlDTDHandler* DTDHandler() const = 0;
    /+virtual+/ void setContentHandler(QXmlContentHandler* handler) = 0;
    /+virtual+/ QXmlContentHandler* contentHandler() const = 0;
    /+virtual+/ void setErrorHandler(QXmlErrorHandler* handler) = 0;
    /+virtual+/ QXmlErrorHandler* errorHandler() const = 0;
    /+virtual+/ void setLexicalHandler(QXmlLexicalHandler* handler) = 0;
    /+virtual+/ QXmlLexicalHandler* lexicalHandler() const = 0;
    /+virtual+/ void setDeclHandler(QXmlDeclHandler* handler) = 0;
    /+virtual+/ QXmlDeclHandler* declHandler() const = 0;
    /+virtual+/ bool parse(ref const(QXmlInputSource) input) = 0;
    /+virtual+/ bool parse(const(QXmlInputSource)* input) = 0;
};

class Q_XML_EXPORT QXmlSimpleReader : public QXmlReader
{
public:
    QXmlSimpleReader();
    /+virtual+/ ~QXmlSimpleReader();

    bool feature(ref const(QString) name, bool *ok = 0) const;
    void setFeature(ref const(QString) name, bool value);
    bool hasFeature(ref const(QString) name) const;

    void* property(ref const(QString) name, bool *ok = 0) const;
    void setProperty(ref const(QString) name, void* value);
    bool hasProperty(ref const(QString) name) const;

    void setEntityResolver(QXmlEntityResolver* handler);
    QXmlEntityResolver* entityResolver() const;
    void setDTDHandler(QXmlDTDHandler* handler);
    QXmlDTDHandler* DTDHandler() const;
    void setContentHandler(QXmlContentHandler* handler);
    QXmlContentHandler* contentHandler() const;
    void setErrorHandler(QXmlErrorHandler* handler);
    QXmlErrorHandler* errorHandler() const;
    void setLexicalHandler(QXmlLexicalHandler* handler);
    QXmlLexicalHandler* lexicalHandler() const;
    void setDeclHandler(QXmlDeclHandler* handler);
    QXmlDeclHandler* declHandler() const;

    bool parse(ref const(QXmlInputSource) input);
    bool parse(const(QXmlInputSource)* input);
    /+virtual+/ bool parse(const(QXmlInputSource)* input, bool incremental);
    /+virtual+/ bool parseContinue();

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
    QScopedPointer<QXmlSimpleReaderPrivate> d_ptr;

    friend class QXmlSimpleReaderLocator;
    friend class QDomHandler;
};

//
// SAX Locator
//

class Q_XML_EXPORT QXmlLocator
{
public:
    QXmlLocator();
    /+virtual+/ ~QXmlLocator();

    /+virtual+/ int columnNumber() const = 0;
    /+virtual+/ int lineNumber() const = 0;
//    QString getPublicId() const
//    QString getSystemId() const
};

//
// SAX handler classes
//

class Q_XML_EXPORT QXmlContentHandler
{
public:
    /+virtual+/ ~QXmlContentHandler() {}
    /+virtual+/ void setDocumentLocator(QXmlLocator* locator) = 0;
    /+virtual+/ bool startDocument() = 0;
    /+virtual+/ bool endDocument() = 0;
    /+virtual+/ bool startPrefixMapping(ref const(QString) prefix, ref const(QString) uri) = 0;
    /+virtual+/ bool endPrefixMapping(ref const(QString) prefix) = 0;
    /+virtual+/ bool startElement(ref const(QString) namespaceURI, ref const(QString) localName, ref const(QString) qName, ref const(QXmlAttributes) atts) = 0;
    /+virtual+/ bool endElement(ref const(QString) namespaceURI, ref const(QString) localName, ref const(QString) qName) = 0;
    /+virtual+/ bool characters(ref const(QString) ch) = 0;
    /+virtual+/ bool ignorableWhitespace(ref const(QString) ch) = 0;
    /+virtual+/ bool processingInstruction(ref const(QString) target, ref const(QString) data) = 0;
    /+virtual+/ bool skippedEntity(ref const(QString) name) = 0;
    /+virtual+/ QString errorString() const = 0;
};

class Q_XML_EXPORT QXmlErrorHandler
{
public:
    /+virtual+/ ~QXmlErrorHandler() {}
    /+virtual+/ bool warning(ref const(QXmlParseException) exception) = 0;
    /+virtual+/ bool error(ref const(QXmlParseException) exception) = 0;
    /+virtual+/ bool fatalError(ref const(QXmlParseException) exception) = 0;
    /+virtual+/ QString errorString() const = 0;
};

class Q_XML_EXPORT QXmlDTDHandler
{
public:
    /+virtual+/ ~QXmlDTDHandler() {}
    /+virtual+/ bool notationDecl(ref const(QString) name, ref const(QString) publicId, ref const(QString) systemId) = 0;
    /+virtual+/ bool unparsedEntityDecl(ref const(QString) name, ref const(QString) publicId, ref const(QString) systemId, ref const(QString) notationName) = 0;
    /+virtual+/ QString errorString() const = 0;
};

class Q_XML_EXPORT QXmlEntityResolver
{
public:
    /+virtual+/ ~QXmlEntityResolver() {}
    /+virtual+/ bool resolveEntity(ref const(QString) publicId, ref const(QString) systemId, QXmlInputSource*& ret) = 0;
    /+virtual+/ QString errorString() const = 0;
};

class Q_XML_EXPORT QXmlLexicalHandler
{
public:
    /+virtual+/ ~QXmlLexicalHandler() {}
    /+virtual+/ bool startDTD(ref const(QString) name, ref const(QString) publicId, ref const(QString) systemId) = 0;
    /+virtual+/ bool endDTD() = 0;
    /+virtual+/ bool startEntity(ref const(QString) name) = 0;
    /+virtual+/ bool endEntity(ref const(QString) name) = 0;
    /+virtual+/ bool startCDATA() = 0;
    /+virtual+/ bool endCDATA() = 0;
    /+virtual+/ bool comment(ref const(QString) ch) = 0;
    /+virtual+/ QString errorString() const = 0;
};

class Q_XML_EXPORT QXmlDeclHandler
{
public:
    /+virtual+/ ~QXmlDeclHandler() {}
    /+virtual+/ bool attributeDecl(ref const(QString) eName, ref const(QString) aName, ref const(QString) type, ref const(QString) valueDefault, ref const(QString) value) = 0;
    /+virtual+/ bool internalEntityDecl(ref const(QString) name, ref const(QString) value) = 0;
    /+virtual+/ bool externalEntityDecl(ref const(QString) name, ref const(QString) publicId, ref const(QString) systemId) = 0;
    /+virtual+/ QString errorString() const = 0;
    // ### Conform to SAX by adding elementDecl
};


class Q_XML_EXPORT QXmlDefaultHandler : public QXmlContentHandler, public QXmlErrorHandler, public QXmlDTDHandler, public QXmlEntityResolver, public QXmlLexicalHandler, public QXmlDeclHandler
{
public:
    QXmlDefaultHandler();
    /+virtual+/ ~QXmlDefaultHandler();

    void setDocumentLocator(QXmlLocator* locator);
    bool startDocument();
    bool endDocument();
    bool startPrefixMapping(ref const(QString) prefix, ref const(QString) uri);
    bool endPrefixMapping(ref const(QString) prefix);
    bool startElement(ref const(QString) namespaceURI, ref const(QString) localName, ref const(QString) qName, ref const(QXmlAttributes) atts);
    bool endElement(ref const(QString) namespaceURI, ref const(QString) localName, ref const(QString) qName);
    bool characters(ref const(QString) ch);
    bool ignorableWhitespace(ref const(QString) ch);
    bool processingInstruction(ref const(QString) target, ref const(QString) data);
    bool skippedEntity(ref const(QString) name);

    bool warning(ref const(QXmlParseException) exception);
    bool error(ref const(QXmlParseException) exception);
    bool fatalError(ref const(QXmlParseException) exception);

    bool notationDecl(ref const(QString) name, ref const(QString) publicId, ref const(QString) systemId);
    bool unparsedEntityDecl(ref const(QString) name, ref const(QString) publicId, ref const(QString) systemId, ref const(QString) notationName);

    bool resolveEntity(ref const(QString) publicId, ref const(QString) systemId, QXmlInputSource*& ret);

    bool startDTD(ref const(QString) name, ref const(QString) publicId, ref const(QString) systemId);
    bool endDTD();
    bool startEntity(ref const(QString) name);
    bool endEntity(ref const(QString) name);
    bool startCDATA();
    bool endCDATA();
    bool comment(ref const(QString) ch);

    bool attributeDecl(ref const(QString) eName, ref const(QString) aName, ref const(QString) type, ref const(QString) valueDefault, ref const(QString) value);
    bool internalEntityDecl(ref const(QString) name, ref const(QString) value);
    bool externalEntityDecl(ref const(QString) name, ref const(QString) publicId, ref const(QString) systemId);

    QString errorString() const;

private:
    QXmlDefaultHandlerPrivate *d;
    mixin Q_DISABLE_COPY;
};

// inlines

/+inline+/ int QXmlAttributes::count() const
{ return length(); }

QT_END_NAMESPACE

#endif // QXML_H
