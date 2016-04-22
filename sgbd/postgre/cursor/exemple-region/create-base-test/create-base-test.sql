CREATE TABLE region
(
   regionid     bigint,
   countryid    bigint,
   regioncode   CHARACTER VARYING (75),
   "name"       CHARACTER VARYING (75),
   active_      boolean
);

CREATE TABLE address
(
   addressid      bigint,
   companyid      bigint,
   userid         bigint,
   username       CHARACTER VARYING (75),
   createdate     timestamp (6) WITHOUT TIME ZONE,
   modifieddate   timestamp (6) WITHOUT TIME ZONE,
   classnameid    bigint,
   classpk        bigint,
   street1        CHARACTER VARYING (75),
   street2        CHARACTER VARYING (75),
   street3        CHARACTER VARYING (75),
   city           CHARACTER VARYING (75),
   zip            CHARACTER VARYING (75),
   regionid       bigint,
   countryid      bigint,
   typeid         integer,
   mailing        boolean,
   primary_       boolean,
   uuid_          CHARACTER VARYING (75)
);