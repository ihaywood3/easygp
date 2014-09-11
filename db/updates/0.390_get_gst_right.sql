CREATE OR REPLACE FUNCTION billing.update_invoice_bill()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
    DECLARE
       pk_invoice iNTEGER;
       gst MONEY;
    BEGIN
        if (TG_OP = 'DELETE') THEN
pk_invoice = OLD.fk_invoice;
else
pk_invoice = NEW.fk_invoice;
end if;
        gst := billing.invoice_gst(pk_invoice);
        update billing.invoices set total_bill=billing.invoice_total(pk)+gst, total_gst=gst where pk = pk_invoice;
        RETURN NULL; -- result is ignored since this is an AFTER trigger
    END;
$function$;

update db.lu_version set lu_minor=390;
